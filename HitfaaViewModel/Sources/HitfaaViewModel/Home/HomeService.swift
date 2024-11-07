//
//  HomeService.swift
//
//
//  Created by Er Baghdasaryan on 07.11.24.
//

import Foundation
import HitfaaModel

public protocol IHomeService {
    func getMotivationTexts() -> [String]
}

public class HomeService: IHomeService {

    public init() { }

    public func getMotivationTexts() -> [String] {
        [
            "Every small step leads to a big victory.",
            "Setbacks are just temporary stops on the road to success.",
            "You control your life, not gambling.",
            "Inner strength always overcomes external challenges.",
            "Today is your chance to start over and become better.",
            "Every day without a bet is a step towards freedom.",
            "You've already started the journey, and that's what matters. Keep going!"
        ]
    }

}
