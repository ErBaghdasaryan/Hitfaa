//
//  HomeViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class HomeViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Home",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let daysWithoutBets = StatView(title: "Days without bets",
                                           image: "stat1")
    private let moneySaves = StatView(title: "Money saved",
                                      image: "stat2")
    private var stack: UIStackView!
    private let daysOfKeeping = StatView(title: "Days of keeping a personal diary",
                                         image: "stat3")

    private let diary = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!.withAlphaComponent(0.05),
                                            text: "Diary",
                                            textColor: .black,
                                            textFont: "Semibold",
                                            imageSystemName: "stat3",
                                            imageColor: .black,
                                            imageSize: .init(width: 24,
                                                             height: 24),
                                            isSystem: false)
    private let relax = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!.withAlphaComponent(0.05),
                                           text: "Relax",
                                           textColor: .black,
                                           textFont: "Semibold",
                                           imageSystemName: "relax1",
                                           imageColor: .black,
                                           imageSize: .init(width: 24,
                                                            height: 24),
                                           isSystem: false)
    private var diaryStack: UIStackView!

    private let dontForget = UILabel(text: "Don't forget to check in",
                                     textColor: .black,
                                     font: UIFont(name: "SFProText-Regular", size: 17))
    private let abstained = ButtonWithImage(backgroundColor: UIColor(hex: "#00A2FF")!,
                                            text: "I abstained",
                                            textColor: .white,
                                            textFont: "Semibold",
                                            imageSystemName: "like",
                                            imageColor: .black,
                                            imageSize: .init(width: 24,
                                                             height: 24),
                                            isSystem: false)
    private let madeABet = ButtonWithImage(backgroundColor: UIColor(hex: "#FC424B")!,
                                           text: "I made a bet",
                                           textColor: .white,
                                           textFont: "Semibold",
                                           imageSystemName: "dislike",
                                           imageColor: .black,
                                           imageSize: .init(width: 24,
                                                            height: 24),
                                           isSystem: false)
    private var checkStack: UIStackView!
    private let motMessage = UILabel(text: "Motivational message",
                                     textColor: .black,
                                     font: UIFont(name: "SFProText-Bold", size: 22))
    private let motivationMessage = MotivationButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonActions()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white
        self.header.textAlignment = .left

        self.stack = UIStackView(arrangedSubviews: [daysWithoutBets, moneySaves],
                                 axis: .horizontal,
                                 spacing: 8)

        self.diaryStack = UIStackView(arrangedSubviews: [diary, relax],
                                      axis: .horizontal,
                                      spacing: 8)

        self.dontForget.textAlignment = .left

        self.checkStack = UIStackView(arrangedSubviews: [abstained, madeABet],
                                      axis: .horizontal,
                                      spacing: 8)

        self.motMessage.textAlignment = .left

        self.view.addSubview(header)
        self.view.addSubview(stack)
        self.view.addSubview(daysOfKeeping)
        self.view.addSubview(diaryStack)
        self.view.addSubview(dontForget)
        self.view.addSubview(checkStack)
        self.view.addSubview(motMessage)
        self.view.addSubview(motivationMessage)
        setupConstraints()
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(166)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        stack.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(78)
        }

        daysOfKeeping.snp.makeConstraints { view in
            view.top.equalTo(stack.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(78)
        }

        diaryStack.snp.makeConstraints { view in
            view.top.equalTo(daysOfKeeping.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }

        dontForget.snp.makeConstraints { view in
            view.top.equalTo(diaryStack.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        checkStack.snp.makeConstraints { view in
            view.top.equalTo(dontForget.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }

        motMessage.snp.makeConstraints { view in
            view.top.equalTo(checkStack.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        motivationMessage.snp.makeConstraints { view in
            view.top.equalTo(motMessage.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(100)
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
}

//MARK: Button actions
extension HomeViewController {
    private func makeButtonActions() {
        motivationMessage.addTarget(self, action: #selector(motivationTapped), for: .touchUpInside)
        abstained.addTarget(self, action: #selector(showAbstainedView), for: .touchUpInside)
        madeABet.addTarget(self, action: #selector(showMadeBet), for: .touchUpInside)
    }

    @objc func showMadeBet() {
        _ = MotivatedView.show(in: self)
    }

    @objc func showAbstainedView() {
        _ = CongratsView.show(in: self)
    }

    @objc func motivationTapped() {
        let text = self.viewModel?.motivationTexts.randomElement()
        self.motivationMessage.setup(with: text!)
    }
}

//MARK: Preview
import SwiftUI

struct HomeViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let homeViewController = HomeViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) -> HomeViewController {
            return homeViewController
        }

        func updateUIViewController(_ uiViewController: HomeViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) {
        }
    }
}
