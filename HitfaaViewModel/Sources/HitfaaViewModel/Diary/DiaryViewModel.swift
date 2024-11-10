//
//  DiaryViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel
import Combine

public protocol IDiaryViewModel {
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var diaries: [DairyModel] { get set }
    func loadData()
}

public class DiaryViewModel: IDiaryViewModel {

    private let diaryService: IDiaryService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var diaries: [DairyModel] = []

    public init(diaryService: IDiaryService) {
        self.diaryService = diaryService
    }

    public func loadData() {
        do {
            self.diaries = try self.diaryService.getDiaries()
        } catch {
            print(error)
        }
    }
}
