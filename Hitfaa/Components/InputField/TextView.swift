//
//  TextView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit

public class TextView: UITextView, UITextViewDelegate {

    private var placeholderText: String = ""
    public var placeholderLabel: UILabel = UILabel()

    public convenience init(placeholder: String) {
        self.init()
        self.placeholderText = placeholder

        configure()
    }

    private func configure() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(hex: "#00A2FF")!.withAlphaComponent(0.05)

        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 16, y: 16)
        addSubview(placeholderLabel)
        placeholderLabel.isHidden = !text.isEmpty

        self.placeholderLabel.attributedText = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.1).cgColor

        self.textColor = .black
        self.font = UIFont(name: "SFProText-Regular", size: 17)
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)

        self.delegate = self
    }

    // MARK: UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

}
