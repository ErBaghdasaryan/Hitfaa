//
//  DairyNavigationModel.swift
//
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import Foundation
import Combine

public final class DairyNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: DairyModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: DairyModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
