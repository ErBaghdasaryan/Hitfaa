//
//  EditDairyViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol IEditDairyViewModel {
    func editDairy(model: DairyModel)
    func deleteDairy(from index: Int)
    var dairy: DairyModel { get set }
}

public class EditDairyViewModel: IEditDairyViewModel {

    private let diaryService: IDiaryService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var dairy: DairyModel

    public init(diaryService: IDiaryService, navigationModel: DairyNavigationModel) {
        self.diaryService = diaryService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.dairy = navigationModel.model
    }

    public func editDairy(model: DairyModel) {
        do {
            try self.diaryService.editDiary(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }

    public func deleteDairy(from index: Int) {
        do {
            try self.diaryService.deleteDiary(byID: index)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
