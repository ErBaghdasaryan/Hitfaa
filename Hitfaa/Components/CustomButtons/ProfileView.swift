//
//  ProfileView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class ProfileView: UIButton {
    private let title = UILabel(text: "Hello,create your profile!",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Bold", size: 17))
    private var image = UIImageView(image: .init(named: "defaultImage"))

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

        self.layer.cornerRadius = 20

        self.title.textAlignment = .left

        self.image.layer.cornerRadius = 20
        self.image.layer.masksToBounds = true

        self.addSubview(image)
        self.addSubview(title)
        setupConstraints()
    }

    private func setupConstraints() {

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(4)
            view.leading.equalToSuperview().offset(4)
            view.width.equalTo(40)
            view.height.equalTo(40)
        }

        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(13)
            view.leading.equalTo(image.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(48)
            view.height.equalTo(22)
        }
    }

    public func setup(with image: UIImage, name: String) {
        self.image.image = image
        self.title.text = "Hello, \(name)!"
        self.setupUI()
    }
}
