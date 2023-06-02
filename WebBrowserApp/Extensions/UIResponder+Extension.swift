//
//  UIResponder+Extension.swift
//  WebBrowserApp
//
//  Created by Fidaa Alamm on 02/06/2023.
//

import Foundation
import UIKit

extension UIResponder {
    static func getName() -> String {
        return String(describing: self)
    }
}
