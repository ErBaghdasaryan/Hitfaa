//
//  ResourcesViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IResourcesViewModel {
    var selectedResources: [ResourcePresentationModel] { get set }
    var articuleResources: [ResourcePresentationModel] { get set }
    var recomendedResources: [ResourcePresentationModel] { get set }
    var researchedResources: [ResourcePresentationModel] { get set }
    func loadData()
}

public class ResourcesViewModel: IResourcesViewModel {

    private let resourcesService: IResourcesService
    public var selectedResources: [ResourcePresentationModel] = []
    public var articuleResources: [ResourcePresentationModel] = []
    public var recomendedResources: [ResourcePresentationModel] = []
    public var researchedResources: [ResourcePresentationModel] = []

    public init(resourcesService: IResourcesService) {
        self.resourcesService = resourcesService
    }

    public func loadData() {
        self.articuleResources = self.resourcesService.getArticleResources()
        self.selectedResources = articuleResources
        self.recomendedResources = self.resourcesService.getRecommentedResources()
        self.researchedResources = self.resourcesService.getResearchedResources()
    }
}
