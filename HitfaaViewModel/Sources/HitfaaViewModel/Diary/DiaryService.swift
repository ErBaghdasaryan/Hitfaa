//
//  DiaryService.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaModel
import SQLite

public protocol IDiaryService {
    func addDiary(_ model: DairyModel) throws -> DairyModel
    func getDiaries() throws -> [DairyModel]
    func deleteDiary(byID id: Int) throws
    func editDiary(_ diary: DairyModel) throws
}

public class DiaryService: IDiaryService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addDiary(_ model: DairyModel) throws -> DairyModel {
        let db = try Connection("\(path)/db.sqlite3")
        let diaries = Table("Diaries")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")
        let dateColumn = Expression<String>("date")

        try db.run(diaries.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(headerColumn)
            t.column(textColumn)
            t.column(dateColumn)
        })

        let rowId = try db.run(diaries.insert(
            headerColumn <- model.title,
            textColumn <- model.text,
            dateColumn <- model.year
        ))

        return DairyModel(id: Int(rowId),
                          title: model.title,
                          text: model.text,
                          year: model.year)
    }

    public func getDiaries() throws -> [DairyModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let diaries = Table("Diaries")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")
        let dateColumn = Expression<String>("date")

        var result: [DairyModel] = []

        for diary in try db.prepare(diaries) {

            let fetchedDiary = DairyModel(id: diary[idColumn],
                                          title: diary[headerColumn],
                                          text: diary[textColumn],
                                          year: diary[dateColumn])

            result.append(fetchedDiary)
        }

        return result
    }

    public func deleteDiary(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let diaries = Table("Diaries")
        let idColumn = Expression<Int>("id")

        let diaryToDelete = diaries.filter(idColumn == id)
        try db.run(diaryToDelete.delete())
    }

    public func editDiary(_ diary: DairyModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let diaries = Table("Diaries")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")
        let dateColumn = Expression<String>("date")

        let diaryToUpdate = diaries.filter(idColumn == diary.id!)
        try db.run(diaryToUpdate.update(
            headerColumn <- diary.title,
            textColumn <- diary.text,
            dateColumn <- diary.year
        ))
    }

}
