//
//  LoginViewController.swift
//  MovieClubApp
//
//  Created by AlexisVaglica on 21/05/2024.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var errorLbl : UILabel!
    @IBOutlet weak var passShowHiddenImage : UIImageView!
    @IBOutlet weak var activityView : UIView!
    @IBOutlet weak var activityIndicatorView : UIActivityIndicatorView!
    
    private var authentication : Authentication? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authentication = Authentication()
        
        configureNotificationKeyboards()
        configureTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    private func configureTextFields() {
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailTF.tag = 1
        passwordTF.tag = 2
    }
    
    private func showHiddenErrorMessage() {
        errorLbl.isHidden = !errorLbl.isHidden
    }
    
    private func showHiddenLoader() {
        activityView.isHidden = !activityView.isHidden
        
        activityIndicatorView.isAnimating ? activityIndicatorView.stopAnimating() :
            activityIndicatorView.startAnimating()
    }
    
    @IBAction func showHiddenPasswordButtonPressed() {
        
        var imageSystemName : String = ""
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        
        if(passwordTF.isSecureTextEntry) {
            imageSystemName = "eye.slash.fill"
        } else {
            imageSystemName = "eye.fill"
        }
        
        passShowHiddenImage.image = UIImage(systemName: imageSystemName)
    }
    
    @IBAction func loginButtonPressed() {
        guard let auth = authentication,
              let email = emailTF.text,
              let password = passwordTF.text
        else { 
            showHiddenErrorMessage()
            return
        }
            
        let isAuthCorrect = auth.authenticationAccount(email: email, password: password)
            
        if isAuthCorrect {
            showHiddenLoader()
        }
        else {
            showHiddenErrorMessage()
        }
    }
    
    @IBAction func signupButtonPressed() {
        let vc = RegisterViewController.instantiateFromNib()
        transitionWithAnimation(to: vc)
    }
}
