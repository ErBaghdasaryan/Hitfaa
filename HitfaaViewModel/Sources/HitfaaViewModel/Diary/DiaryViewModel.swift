//
//  DiaryViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IDiaryViewModel {

}

public class DiaryViewModel: IDiaryViewModel {

    private let diaryService: IDiaryService

    public init(diaryService: IDiaryService) {
        self.diaryService = diaryService
    }
}
