//
//  RelaxTableViewCell.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import SnapKit
import HitfaaViewModel
import HitfaaModel
import Combine

final class RelaxTableViewCell: UITableViewCell, IReusableView {

    private let content = UIView()

    private let date = UILabel(text: "",
                               textColor: UIColor.gray,
                               font: UIFont(name: "SFProText-Semibold", size: 12))
    private let header = UILabel(text: "",
                                 textColor: UIColor.black,
                                 font: UIFont(name: "SFProText-Semibold", size: 17))
    private let image = UIImageView(image: .init(named: "relaxCellImage"))
    private let state = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Regular", size: 12))

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

        self.content.layer.cornerRadius = 10

        self.date.textAlignment = .left
        self.header.textAlignment = .left

        addSubview(content)
        self.content.addSubview(image)
        self.content.addSubview(date)
        self.content.addSubview(header)
        self.content.addSubview(state)
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
            view.top.equalToSuperview().offset(16)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        date.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(16)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(date.snp.bottom).offset(4)
            view.leading.equalTo(image.snp.trailing).offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        state.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(85)
            view.height.equalTo(24)
        }
    }

    public func setup(model: RelaxModel) {
        self.date.text = model.year
        self.header.text = model.title

        switch model.state {
        case "onhold":
            self.state.layer.cornerRadius = 5
            self.state.layer.masksToBounds = true
            self.state.backgroundColor = UIColor(hex: "#084176")
            self.state.textColor = .white
            self.state.text = "On hold"
        case "continue":
            self.state.layer.cornerRadius = 5
            self.state.layer.masksToBounds = true
            self.state.backgroundColor = UIColor(hex: "#00A2FF")
            self.state.textColor = .white
            self.state.text = "Still reading"
        case "compete":
            self.state.layer.cornerRadius = 5
            self.state.layer.masksToBounds = true
            self.state.backgroundColor = UIColor(hex: "#40D665")
            self.state.textColor = .white
            self.state.text = "Completed"
        default:
            self.state.layer.cornerRadius = 5
            self.state.layer.masksToBounds = true
            self.state.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)
            self.state.textColor = .black
            self.state.text = "Not started"
        }

        self.setupUI()
    }
}
