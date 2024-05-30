//
//  UIViewController.swift
//  MovieClubApp
//
//  Created by AlexisVaglica on 22/05/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib(self)
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configureNotificationKeyboards() {
               subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
               
               subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
    }
    
    func transitionWithAnimation(to vc: UIViewController, with animationType: String = "flip") {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType(rawValue: animationType)
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)

        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    @objc internal func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField
        else {
            return
        }
                
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY >= keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (view.frame.maxY - keyboardTopY) - textBoxY

            view.frame.origin.y = newFrameY > 0 ? -newFrameY : newFrameY
        }
    }
    
    @objc internal func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
