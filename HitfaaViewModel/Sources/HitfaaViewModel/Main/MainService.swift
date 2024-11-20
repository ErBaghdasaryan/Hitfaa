//
//  MainService.swift
//  
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import HitfaaModel

public protocol IMainService {
    func getMainItems() -> [MainPresentationModel]
}

public class MainService: IMainService {
    public init() { }
    
    public func getMainItems() -> [MainPresentationModel] {
        [
            MainPresentationModel(image: "main18",
                                        header: "Who will win? Decide and earn!",
                                        description: "Decide the outcome"),
            MainPresentationModel(image: "main24",
                                        header: "Rate our app in the AppStore",
                                        description: "Help make the app even better")
        ]
    }
}
