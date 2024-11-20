//
//  FeatureViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import HitfaaModel

public protocol IFeatureViewModel {
    var url: String { get }
    var appStorageService: IAppStorageService { get set }
}

public class FeatureViewModel: IFeatureViewModel {

    public var url: String {
        get {
            return appStorageService.getData(key: .webUrl) ?? ""
        }
    }

    private let featureService: IFeatureService
    public var appStorageService: IAppStorageService

    public init(featureService: IFeatureService,
                appStorageService: IAppStorageService) {
        self.featureService = featureService
        self.appStorageService = appStorageService
    }
}
