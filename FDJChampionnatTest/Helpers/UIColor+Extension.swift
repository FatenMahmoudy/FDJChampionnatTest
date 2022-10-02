//
//  UIColor+Extension.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 30/09/2022.
//

import Foundation
import UIKit

extension UIColor {
  static let backgroundColor: UIColor = {
    return UIColor(named: "backgroundColor") ?? .clear
  }()
}
