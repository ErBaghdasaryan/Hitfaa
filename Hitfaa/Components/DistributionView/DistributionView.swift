//
//  DistributionView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import SnapKit
import HitfaaViewModel
import HitfaaModel
import Combine

final class DistributionView: UIView, IReusableView {

    public let subheader = HeaderField(placeholder: "0$",
                                        sfPro: "Bold",
                                        size: 28,
                                        isCentered: false)
    private let header = UILabel(text: "",
                                 textColor: UIColor.black,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))
    private let image = UIImageView()

    private func setupUI() {

        self.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
        self.layer.cornerRadius = 10

        self.subheader.textAlignment = .left
        self.header.textAlignment = .left

        self.addSubview(image)
        self.addSubview(header)
        self.addSubview(subheader)
        setupConstraints()
    }

    private func setupConstraints() {

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(30)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        subheader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(4)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }
    }

    public func setup(model: ChecklistPresentationModel) {
        self.header.text = model.header

        self.image.image = UIImage(named: model.image)

        self.setupUI()
    }
}
