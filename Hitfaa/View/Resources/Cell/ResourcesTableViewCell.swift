//
//  ResourcesTableViewCell.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import SnapKit
import HitfaaViewModel
import HitfaaModel
import Combine

final class ResourcesTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()

    private let subheader = UILabel(text: "",
                               textColor: UIColor.gray,
                               font: UIFont(name: "SFProText-Semibold", size: 12))
    private let header = UILabel(text: "",
                                 textColor: UIColor.black,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))
    private let image = UIImageView()

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

        self.content.layer.cornerRadius = 10

        self.subheader.textAlignment = .left
        self.header.textAlignment = .left
        self.header.numberOfLines = 2

        addSubview(content)
        self.content.addSubview(image)
        self.content.addSubview(header)
        self.content.addSubview(subheader)
        setupConstraints()
    }

    private func setupConstraints() {

        content.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(4)
            view.leading.equalToSuperview().offset(3)
            view.trailing.equalToSuperview().inset(3)
            view.bottom.equalToSuperview().inset(4)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(32)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(44)
        }

        subheader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(4)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(16)
        }
    }

    public func setup(model: ResourcePresentationModel) {
        self.subheader.text = model.description
        self.header.text = model.header

        self.image.image = UIImage(named: model.image)

        self.setupUI()
    }
}
