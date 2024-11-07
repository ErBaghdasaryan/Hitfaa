//
//  RelaxViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import UIKit
import HitfaaModel

public protocol IRelaxViewModel {

}

public class RelaxViewModel: IRelaxViewModel {

    private let relaxService: IRelaxService

    public init(relaxService: IRelaxService) {
        self.relaxService = relaxService
    }
}
