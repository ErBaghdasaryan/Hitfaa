//
//  EditResourcesViewModel.swift
//
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaModel

public protocol IEditResourcesViewModel {
    var resource: ResourcePresentationModel { get set }
}

public class EditResourcesViewModel: IEditResourcesViewModel {
    
    private let resourcesService: IResourcesService
    public var resource: ResourcePresentationModel

    public init(resourcesService: IResourcesService, navigationModel: ResourceNavigationModel) {
        self.resourcesService = resourcesService
        self.resource = navigationModel.model
    }
}
