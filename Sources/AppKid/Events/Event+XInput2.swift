//
//  Event+XInput2.swift
//  AppKid
//
//  Created by Serhii Mumriak on 21.04.2020.
//

import Foundation
import CoreFoundation
import CX11.X
import CX11.Xlib
import CXInput2

internal extension XInput2EventTypeMask {
    static let keyboard: XInput2EventTypeMask = [.keyPress, .keyRelease]
    static let mouse: XInput2EventTypeMask = [.buttonPress, .buttonRelease]
    static let enterLeave: XInput2EventTypeMask = [.enter, .leave]
    static let focus: XInput2EventTypeMask = [.focusIn, .focusOut]

    static let basic: XInput2EventTypeMask = [.keyboard, .mouse, .motion, .enterLeave, .focus]
}

fileprivate extension XEvent {
    var eventTypeFromXInput2Event: Event.EventType {
        guard let type = XInput2EventType(rawValue: xcookie.evtype) else {
            return .noEvent
        }

        switch type {
        case .keyPress, .keyRelease:
            return keyboardEventType

        case .buttonPress, .buttonRelease:
            return mouseEventType

        case .enter:
            return .mouseEntered

        case .leave:
            return .mouseExited

        default:
            return .noEvent
        }
    }
}

fileprivate extension XEvent {
    var keyboardEventType: Event.EventType {
        switch XInput2EventType(rawValue: xcookie.evtype) {
        case .keyPress: return .keyDown
        case .keyRelease: return .keyUp
        default: return .noEvent
        }
    }

    var mouseEventType: Event.EventType {
        switch XInput2EventType(rawValue: xcookie.evtype) {
        case .buttonPress: return .leftMouseDown
        case .buttonRelease: return .leftMouseUp
        default: return .noEvent
        }
    }
}

internal extension Event {
    convenience init(xInput2Event: XEvent, timestamp: TimeInterval, displayScale: CGFloat) throws {
        let type = xInput2Event.eventTypeFromXInput2Event

        if type == .noEvent {
            throw EventCreationError.eventIgnored
        }

        let deviceEvent: XIDeviceEvent = xInput2Event.xcookie.data.assumingMemoryBound(to: XIDeviceEvent.self).pointee

        guard let windowNumber = Application.shared.windows.firstIndex(where: { $0.nativeWindow.windowID == deviceEvent.event }) else {
            throw EventCreationError.noWindow
        }

        switch type {
        case _ where EventType.mouseEventTypes.contains(type):
            let deviceEvent = xInput2Event.deviceEvent

            let location = CGPoint(x: CGFloat(deviceEvent.event_x) / displayScale, y: CGFloat(deviceEvent.event_y) / displayScale)
//            ModifierFlags(x11KeyMask: deviceEvent.state)
            try self.init(withMouseEventType: type, location: location, modifierFlags: .none, timestamp: timestamp, windowNumber: windowNumber, eventNumber: 0, clickCount: 0, pressure: 0.0)

//            buttonNumber = 0

        default:
            throw EventCreationError.eventIgnored
        }
    }
}

fileprivate extension XEvent {
    var deviceEvent: XIDeviceEvent {
        return xcookie.data.assumingMemoryBound(to: XIDeviceEvent.self).pointee
    }
}
