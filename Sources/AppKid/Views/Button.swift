//
//  Button.swift
//  AppKid
//
//  Created by Serhii Mumriak on 19/2/20.
//

import Foundation
import CairoGraphics

open class Button: Control {
    var stateToTitle: [Control.State: String] = [:]
    var stateToTextColor: [Control.State: CairoGraphics.CGColor] = [:]

    fileprivate(set) open var titleLabel: Label?

    open override var state: Control.State {
        didSet {
            updateText()
        }
    }

    public override init(with frame: CGRect) {
        var labelFrame = frame
        labelFrame.origin = .zero
        labelFrame = labelFrame.insetBy(dx: 8.0, dy: 8.0)
        let titleLabel = Label(with: labelFrame)
        titleLabel.backgroundColor = .clear

        self.titleLabel = titleLabel

        super.init(with: frame)

        add(subview: titleLabel)
    }

    open func set(title: String?, for state: Control.State) {
        if let title = title {
            stateToTitle[state] = title
        } else {
            stateToTitle.removeValue(forKey: state)
        }

        updateText()
        setNeedsLayout()
    }

    open func set(textColor: CairoGraphics.CGColor?, for state: Control.State) {
        if let textColor = textColor {
            stateToTextColor[state] = textColor
        } else {
            stateToTextColor.removeValue(forKey: state)
        }

        updateText()
    }

    internal func updateText() {
        guard let titleLabel = titleLabel else { return }
        let state: State = {
            if isEnabled {
                if isSelected {
                    return .selected
                } else if isHighlighted {
                    return .highlighted
                } else {
                    return .normal
                }
            } else {
                return .disabled
            }
        }()

        titleLabel.text = stateToTitle[state] ?? stateToTitle[.normal]
        titleLabel.textColor = stateToTextColor[state] ?? stateToTextColor[.normal] ?? Button.defaultTitleColor
    }

    open override func render(in context: CairoGraphics.CGContext) {
        super.render(in: context)

        context.strokeColor = .black
        context.lineWidth = 2.0
        context.stroke(bounds)
    }
}

public extension Button {
    static let defaultTitleColor: CairoGraphics.CGColor = .black
}
