//
//  OnboardingViewController.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import HitfaaViewModel
import SnapKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let bottomView = UIView()
    private let header = UILabel(text: "",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let descriptionLabel = UILabel(text: "",
                                           textColor: .white.withAlphaComponent(0.2),
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private let continueButton = ButtonWithImage(backgroundColor: .white,
                                                 text: "Next",
                                                 textColor: .black,
                                                 textFont: "Semibold",
                                                 imageSystemName: "chevron.right",
                                                 imageColor: .black,
                                                 imageSize: .init(width: 24,
                                                                  height: 24))
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor.white

        self.bottomView.backgroundColor = UIColor(hex: "#00A2FF")
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        header.textAlignment = .center
        header.numberOfLines = 2

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        setupConstraints()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width
            let heightt = self.view.frame.size.height - 300
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        self.view.addSubview(bottomView)
        self.view.addSubview(collectionView)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(continueButton)

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(266)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalTo(bottomView.snp.top)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(32)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(68)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(44)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(64)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
            view.width.equalTo(98)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
    }

    private func resetLabelSizes() {
        header.snp.updateConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(43)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(34)
        }

        descriptionLabel.snp.updateConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(20)
        }

        self.header.numberOfLines = 1
        self.descriptionLabel.numberOfLines = 1
    }

    @objc func continueButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            self.resetLabelSizes()
        } else {
            OnboardingRouter.showTabBarViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        descriptionLabel.text = viewModel?.onboardingItems[indexPath.row].description
        header.text = viewModel?.onboardingItems[indexPath.row].header
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}

