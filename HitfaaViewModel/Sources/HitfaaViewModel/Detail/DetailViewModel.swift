//
//  DetailViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import Foundation
import HitfaaModel

public protocol IDetailViewModel {

}

public class DetailViewModel: IDetailViewModel {

    private let detailService: IDetailService

    public init(detailService: IDetailService) {
        self.detailService = detailService
    }
}
