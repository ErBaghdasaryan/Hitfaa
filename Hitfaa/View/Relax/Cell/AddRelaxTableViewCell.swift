//
//  AddRelaxTableViewCell.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import SnapKit
import HitfaaViewModel
import HitfaaModel
import Combine

final class AddRelaxTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()

    private let header = UILabel(text: "",
                                 textColor: UIColor.white,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))
    private let image = UIImageView(image: .init(named: "plus"))

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor(hex: "#00A2FF")

        self.content.layer.cornerRadius = 10

        self.header.textAlignment = .left

        addSubview(content)
        self.content.addSubview(image)
        self.content.addSubview(header)
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
            view.top.equalToSuperview().offset(21)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(21)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }
    }

    public func setup(with header: String) {
        self.header.text = header

        self.setupUI()
    }
}
