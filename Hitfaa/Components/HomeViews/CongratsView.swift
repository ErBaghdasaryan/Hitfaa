//
//  CongratsView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import SnapKit

final class CongratsView: UIView {

    private var frameView: UIView!
    private var titleLabel = UILabel(text: "Congratulation!",
                                     textColor: UIColor.black,
                                     font: UIFont(name: "SFProText-Bold", size: 28))
    private var messageLabel = UILabel(text: "You are one step closer to your well-being again!",
                                      textColor: UIColor.black,
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private var dairyButton = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                               text: "Diary",
                                               textColor: .white,
                                               textFont: "Regular",
                                               imageSystemName: "book.closed.fill",
                                               imageColor: .white,
                                               imageSize: .init(width: 24, height: 24))
    private var backButton = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                               text: "Back",
                                               textColor: .white,
                                               textFont: "Regular",
                                               imageSystemName: "chevron.backward",
                                               imageColor: .white,
                                               imageSize: .init(width: 24, height: 24))
    private var stack: UIStackView!
    private var superViewController: UIViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActions()
    }

    private func setupUI() {
        backgroundColor = UIColor(white: 0.0, alpha: 0.3)

        frameView = UIView()
        frameView.layer.cornerRadius = 15
        frameView.layer.masksToBounds = true
        frameView.backgroundColor = .white

        self.messageLabel.numberOfLines = 2

        self.stack = UIStackView(arrangedSubviews: [dairyButton, backButton],
                                 axis: .horizontal,
                                 spacing: 8)

        addSubview(frameView)
        frameView.addSubview(titleLabel)
        frameView.addSubview(messageLabel)
        frameView.addSubview(stack)

        setupConstraints()
    }

    private func setupConstraints() {
        frameView.snp.makeConstraints { view in
            view.center.equalToSuperview()
            view.width.equalTo(358)
            view.height.equalTo(214)
        }

        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(32)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(34)
        }

        messageLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(16)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(44)
        }

        stack.snp.makeConstraints { view in
            view.top.equalTo(messageLabel.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(32)
            view.trailing.equalToSuperview().inset(32)
            view.height.equalTo(40)
        }
    }

    private func setupActions() {
        dairyButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc private func dismissView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    static func show(in viewController: UIViewController) -> CongratsView {
        let popup = CongratsView(frame: viewController.view.bounds)
        popup.superViewController = viewController
        popup.alpha = 0.0
        viewController.view.addSubview(popup)

        UIView.animate(withDuration: 0.3) {
            popup.alpha = 1.0
        }

        return popup
    }
}

