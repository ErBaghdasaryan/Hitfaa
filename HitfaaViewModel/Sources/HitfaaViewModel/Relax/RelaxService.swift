//
//  RelaxService.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaModel
import SQLite

public protocol IRelaxService {
    func addRelax(_ model: RelaxModel) throws -> RelaxModel
    func getRelaxes() throws -> [RelaxModel]
    func editRelax(_ relax: RelaxModel) throws
}

public class RelaxService: IRelaxService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addRelax(_ model: RelaxModel) throws -> RelaxModel {
        let db = try Connection("\(path)/db.sqlite3")
        let relaxes = Table("Relaxes")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")
        let dateColumn = Expression<String>("date")
        let stateColumn = Expression<String>("state")

        try db.run(relaxes.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(headerColumn)
            t.column(textColumn)
            t.column(dateColumn)
            t.column(stateColumn)
        })

        let rowId = try db.run(relaxes.insert(
            headerColumn <- model.title,
            textColumn <- model.text,
            dateColumn <- model.year,
            stateColumn <- model.state
        ))

        return RelaxModel(id: Int(rowId),
                          title: model.title,
                          text: model.text,
                          year: model.year,
                          state: model.state)
    }

    public func getRelaxes() throws -> [RelaxModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let relaxes = Table("Relaxes")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")
        let dateColumn = Expression<String>("date")
        let stateColumn = Expression<String>("state")

        var result: [RelaxModel] = []

        for relax in try db.prepare(relaxes) {

            let fetchedRelax = RelaxModel(id: relax[idColumn],
                                          title: relax[headerColumn],
                                          text: relax[textColumn],
                                          year: relax[dateColumn],
                                          state: relax[stateColumn])

            result.append(fetchedRelax)
        }

        return result
    }

    public func editRelax(_ relax: RelaxModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let relaxes = Table("Relaxes")
        let idColumn = Expression<Int>("id")
        let headerColumn = Expression<String>("header")
        let textColumn = Expression<String>("text")
        let dateColumn = Expression<String>("date")
        let stateColumn = Expression<String>("state")

        let relaxToUpdate = relaxes.filter(idColumn == relax.id!)
        try db.run(relaxToUpdate.update(
            headerColumn <- relax.title,
            textColumn <- relax.text,
            dateColumn <- relax.year,
            stateColumn <- relax.state
        ))
    }

}
