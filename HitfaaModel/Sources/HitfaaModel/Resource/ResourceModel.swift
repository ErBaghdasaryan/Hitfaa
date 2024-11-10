//
//  ResourceModel.swift
//
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import Foundation

public struct ResourcePresentationModel {
    public let image: String
    public let header: String
    public let description: String
    public let text: String

    public init(image: String, header: String, description: String, text: String) {
        self.image = image
        self.header = header
        self.description = description
        self.text = text
    }
}
