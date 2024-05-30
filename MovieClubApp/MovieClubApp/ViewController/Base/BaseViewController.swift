//
//  BaseViewController.swift
//  MovieClubApp
//
//  Created by AlexisVaglica on 23/05/2024.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBackButtonText()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    internal func changeTextField() {}
    
    private func removeBackButtonText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension BaseViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return false
        }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeTextField()
    }
}
