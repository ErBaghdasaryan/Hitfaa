//
//  ChecklistViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IChecklistViewModel {

}

public class ChecklistViewModel: IChecklistViewModel {

    private let checklistService: IChecklistService

    public init(checklistService: IChecklistService) {
        self.checklistService = checklistService
    }
}
