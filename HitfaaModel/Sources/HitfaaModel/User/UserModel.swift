//
//  UserModel.swift
//
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit

public struct UserModel {
    public let id: Int?
    public let image: UIImage
    public let name: String
    public let moneyAmount: String
    public let year: String

    public init(id: Int? = nil, image: UIImage, name: String, moneyAmount: String, year: String) {
        self.id = id
        self.image = image
        self.name = name
        self.moneyAmount = moneyAmount
        self.year = year
    }
}
