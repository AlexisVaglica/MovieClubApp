//
//  UIView+Extensions.swift
//  MovieClubApp
//
//  Created by viciecal on 24/05/2024.
//

import Foundation
import UIKit

extension UIView {
    static func instantiateFromNib() -> Self {
        @discardableResult
        func instantiateFromNib<T: UIView>(_ viewType: T.Type) -> T {
            let nib = UINib(nibName: String(describing: T.self), bundle: nil)
            let contentView = nib.instantiate(withOwner: T.self, options: nil).first as! T
              return contentView
          }
          return instantiateFromNib(self)
      }
}
