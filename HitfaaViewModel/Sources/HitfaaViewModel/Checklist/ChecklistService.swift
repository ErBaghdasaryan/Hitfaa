//
//  ChecklistService.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaModel

public protocol IChecklistService {
    func getChecklists() -> [ChecklistPresentationModel]
}

public class ChecklistService: IChecklistService {

    public init() { }

    public func getChecklists() -> [ChecklistPresentationModel] {
        [
            ChecklistPresentationModel(image: "charity",
                                       header: "Charity",
                                       description: "Donate money to funds supporting people with addictions or helping those in need."),
            ChecklistPresentationModel(image: "education",
                                       header: "Education",
                                       description: "Invest in courses or training for professional development."),
            ChecklistPresentationModel(image: "sportsFinance",
                                       header: "Sports and Fitness",
                                       description: "Enroll in gym memberships, attend yoga classes, or participate in marathons."),
            ChecklistPresentationModel(image: "hobbies",
                                       header: "Hobbies",
                                       description: "Fund your passions, such as painting, music, or cooking."),
            ChecklistPresentationModel(image: "travel",
                                       header: "Travel",
                                       description: "Plan small trips or excursions to enrich your experiences."),
            ChecklistPresentationModel(image: "personalFinanse",
                                       header: "Personal Finance",
                                       description: "Create a fund for financial security, savings, or investments."),
        ]
    }

}
