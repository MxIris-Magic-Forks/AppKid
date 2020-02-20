//
//  Label.swift
//  AppKid
//
//  Created by Serhii Mumriak on 17/2/20.
//

import Foundation
import CoreFoundation
import CairoGraphics

open class Label: View {
    public var text: String? = nil {
        didSet {
            layout.text = text ?? ""
        }
    }
    public var textColor: CairoGraphics.CGColor = .black
    internal var layout = TextLayout()

    public override func render(in context: CairoGraphics.CGContext) {
        super.render(in: context)

        let textRect = self.textRect(for: bounds, limitedToNumberOfLines: 0)

        renderText(in: context, textRect: textRect)
    }

    public func textRect(for bounds: CGRect, limitedToNumberOfLines numberOfLinex: Int) -> CGRect {
        return bounds
    }

    public func renderText(in context: CairoGraphics.CGContext, textRect: CGRect) {
        layout.render(in: context, rect: textRect)
    }
}
