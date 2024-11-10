//
//  RelaxModel.swift
//  
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import UIKit

public struct RelaxModel {
    public let id: Int?
    public let title: String
    public let text: String
    public let year: String
    public let state: String

    public init(id: Int? = nil, title: String, text: String, year: String, state: String) {
        self.id = id
        self.title = title
        self.text = text
        self.year = year
        self.state = state
    }
}
