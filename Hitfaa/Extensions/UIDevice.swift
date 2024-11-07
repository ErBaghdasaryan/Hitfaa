//
//  UIDevice.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit

enum DeviceType {
    case iPhone
    case iPad
}

extension UIDevice {
    static var currentDeviceType: DeviceType {
        return UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }
}
