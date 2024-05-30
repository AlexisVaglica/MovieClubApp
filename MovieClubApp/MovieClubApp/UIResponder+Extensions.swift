//
//  UIResponder+Extensions.swift
//  MovieClubApp
//
//  Created by AlexisVaglica on 22/05/2024.
//

import Foundation
import UIKit

extension UIResponder {
    private struct Static {
        static weak var responder : UIResponder?
    }
    
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.thisSelf), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func thisSelf() {
        Static.responder = self
    }
}
