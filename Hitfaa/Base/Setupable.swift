//
//  Setupable.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
