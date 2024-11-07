//
//  TabBarService.swift
//
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel
import SQLite

public protocol ITabBarService {
    func getUser() throws -> UserModel?
}

public class TabBarService: ITabBarService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

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

}
