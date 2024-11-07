//
//  StatisticView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

final class StatView: UIView {
    private let title = UILabel(text: "",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Semibold", size: 12))
    private let count = UILabel(text: "0",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Bold", size: 28))
    private var image = UIImageView()
    private var isMoney: Bool = false

    public init(title: String, image: String, isMoney: Bool = false) {
        self.title.text = title
        self.image.image = UIImage(named: image)
        if isMoney {
            self.count.text = "0$"
        }
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor(hex: "#00A2FF")?.withAlphaComponent(0.05)

        self.layer.cornerRadius = 10

        self.title.textAlignment = .left

        addSubview(title)
        addSubview(count)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(10)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(16)
        }

        count.snp.makeConstraints { view in
            view.top.equalTo(title.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(20)
            view.height.equalTo(20)
        }
    }

    public func setup(with count: String) {
        if isMoney {
            self.count.text = "\(count)$"
        } else {
            self.count.text = count
        }
        self.setupUI()
    }
}
