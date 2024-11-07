//
//  ButtonWithImage.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import HitfaaModel

final class ButtonWithImage: UIButton {
    private let title: UILabel!
    private var image = UIImageView()
    private var stack: UIStackView!

    public init(backgroundColor: UIColor,
                text: String,
                textColor: UIColor,
                textFont: String,
                imageSystemName: String,
                imageColor: UIColor,
                imageSize: CGSize) {
        self.title = UILabel(text: text,
                             textColor: textColor,
                             font: UIFont(name: "SFProText-\(textFont)", size: 17))
        self.image.image = UIImage(systemName: imageSystemName)?.withRenderingMode(.alwaysTemplate)
        self.image.tintColor = imageColor
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.layer.cornerRadius = 10

        self.title.textAlignment = .left

        self.stack = UIStackView(arrangedSubviews: [title, image],
                                 axis: .horizontal,
                                 spacing: 1)
        self.stack.distribution = .fillProportionally

        self.addSubview(stack)
        setupConstraints()
    }

    private func setupConstraints() {

        stack.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(9)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }
    }
}
