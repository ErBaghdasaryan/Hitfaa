//
//  ReusableView.swift
//  Hitfaa
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import UIKit

protocol IReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension IReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
