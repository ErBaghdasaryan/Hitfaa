//
//  InputField.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit

public class InputField: UIView {
    let mainLabel: UILabel
    public var helperLabel: UILabel?
    public var textField: TextField

    public init(labelText: String,
                placeholder: String) {
        self.mainLabel = UILabel(text: labelText,
                                 textColor: UIColor.black,
                                 font: UIFont(name: "SFProText-Semibold", size: 12))

        self.textField = TextField(placeholder: placeholder)

        super.init(frame: .zero)

        self.addSubview(mainLabel)
        self.addSubview(textField)

        mainLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.height.equalTo(16)
        }

        textField.snp.makeConstraints { view in
            view.top.equalTo(mainLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(38)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
