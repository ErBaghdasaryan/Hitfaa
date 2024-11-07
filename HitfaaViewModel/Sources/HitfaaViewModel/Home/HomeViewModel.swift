//
//  HomeViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IHomeViewModel {
    var motivationTexts: [String] { get set }
    func loadData()
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService
    public var motivationTexts: [String] = []

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }

    public func loadData() {
        self.motivationTexts = homeService.getMotivationTexts()
    }
}
