//
//  ResourcesViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IResourcesViewModel {

}

public class ResourcesViewModel: IResourcesViewModel {

    private let resourcesService: IResourcesService

    public init(resourcesService: IResourcesService) {
        self.resourcesService = resourcesService
    }
}
