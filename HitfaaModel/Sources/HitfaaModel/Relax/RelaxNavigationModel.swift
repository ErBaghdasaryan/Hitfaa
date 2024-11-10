//
//  RelaxNavigationModel.swift
//  
//
//  Created by Er Baghdasaryan on 08.11.24.
//

import Foundation
import Combine

public final class RelaxNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: RelaxModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: RelaxModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
