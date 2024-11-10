//
//  AddDairyViewModel.swift
//
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol IAddDairyViewModel {
    func addDairy(model: DairyModel)
}

public class AddDairyViewModel: IAddDairyViewModel {

    private let diaryService: IDiaryService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(diaryService: IDiaryService, navigationModel: AddNavigationModel) {
        self.diaryService = diaryService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func addDairy(model: DairyModel) {
        do {
            _ = try self.diaryService.addDiary(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
