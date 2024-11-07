//
//  ProfileService.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel
import SQLite

public protocol IProfileService {
    func addUser(_ model: UserModel) throws -> UserModel
    func getUser() throws -> UserModel?
    func updateUser(_ model: UserModel) throws
}

public class ProfileService: IProfileService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addUser(_ model: UserModel) throws -> UserModel {
        let db = try Connection("\(path)/db.sqlite3")
        let users = Table("User")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let moneyAmountColumn = Expression<String>("moneyAmount")
        let yearColumn = Expression<String>("year")

        try db.run(users.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(imageColumn)
            t.column(nameColumn)
            t.column(moneyAmountColumn)
            t.column(yearColumn)
        })
        
        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }
        
        let rowId = try db.run(users.insert(
            imageColumn <- imageData,
            nameColumn <- model.name,
            moneyAmountColumn <- model.moneyAmount,
            yearColumn <- model.year
        ))
        
        return UserModel(id: Int(rowId),
                         image: model.image,
                         name: model.name,
                         moneyAmount: model.moneyAmount,
                         year: model.year)
    }
    
    public func getUser() throws -> UserModel? {
        let db = try Connection("\(path)/db.sqlite3")
        let users = Table("User")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let moneyAmountColumn = Expression<String>("moneyAmount")
        let yearColumn = Expression<String>("year")

        if let user = try db.pluck(users) {
            guard let image = UIImage(data: user[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }
            
            return UserModel(id: user[idColumn],
                             image: image,
                             name: user[nameColumn],
                             moneyAmount: user[moneyAmountColumn],
                             year: user[yearColumn])
        }
        return nil
    }
    
    public func updateUser(_ model: UserModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let users = Table("User")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let moneyAmountColumn = Expression<String>("moneyAmount")
        let yearColumn = Expression<String>("year")
        
        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        if let user = try db.pluck(users) {
            let userToUpdate = users.filter(idColumn == user[idColumn])
            try db.run(userToUpdate.update(
                imageColumn <- imageData,
                nameColumn <- model.name,
                moneyAmountColumn <- model.moneyAmount,
                yearColumn <- model.year
            ))
        } else {
            try _ = addUser(model)
        }
    }

}
