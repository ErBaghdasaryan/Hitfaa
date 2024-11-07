//
//  OnboardingService.swift
//  
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit
import HitfaaModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }
    
    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "onboarding1",
                                        header: "Take a step toward freedom from addiction",
                                        description: "Track your days without betting and money saved"),
            OnboardingPresentationModel(image: "onboarding2",
                                        header: "Keep a personal journal",
                                        description: "Keep your team in good shape")
        ]
    }
}
