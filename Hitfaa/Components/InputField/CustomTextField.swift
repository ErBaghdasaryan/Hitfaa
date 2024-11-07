//
//  CustomTextField.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit

public class TextField: UITextField {

    public convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(hex: "#00A2FF")!.withAlphaComponent(0.05)
        self.textColor = .black
        self.font = UIFont(name: "SFProText-Regular", size: 17)
        self.rightViewMode = .always

        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.1).cgColor

        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }

    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        
        if rect.origin.x.isNaN || rect.origin.x.isInfinite {
            rect.origin.x = bounds.width - rect.width
        } else {
            rect.origin.x -= 14
        }
    
        return rect
    }
}
