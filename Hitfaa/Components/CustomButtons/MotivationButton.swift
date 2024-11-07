//
//  MotivationButton.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class MotivationButton: UIButton {

    private let title = UILabel(text: "Tap on me",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 12))
    private let motivation = UILabel(text: "You are stronger than temptations. Don't stop!",
                                      textColor: .white,
                                      font: UIFont(name: "SFProText-Regular", size: 17))

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(hex: "#00A2FF")

        self.title.textAlignment = .left
        self.motivation.textAlignment = .center
        self.motivation.numberOfLines = 2

        self.addSubview(title)
        self.addSubview(motivation)
        setupConstraints()
    }

    private func setupConstraints() {

        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(16)
        }

        motivation.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(40)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(44)
        }
    }

    public func setup(with motivationMessage: String) {
        self.motivation.text = motivationMessage
    }
}
