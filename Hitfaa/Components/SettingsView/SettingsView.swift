//
//  SettingsView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class SettingsView: UIButton {
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Semibold", size: 17))
    private var image = UIImageView()

    public init(title: String, image: String) {
        self.title.text = title
        self.image.image = UIImage(named: image)
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor(hex: "#00A2FF")

        self.layer.cornerRadius = 10

        self.title.textAlignment = .left

        addSubview(title)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(9)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(80)
            view.height.equalTo(22)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(8)
            view.width.equalTo(24)
            view.height.equalTo(24)
        }
    }
}
