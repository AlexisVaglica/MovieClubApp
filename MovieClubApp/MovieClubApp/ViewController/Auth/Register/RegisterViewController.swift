//
//  RegisterViewController.swift
//  MovieClubApp
//
//  Created by viciecal on 27/05/2024.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var rePasswordTF : UITextField!
    @IBOutlet weak var registerBtn : UIButton!
    
    @IBOutlet weak var passShowHiddenImage : UIImageView!
    @IBOutlet weak var rePassShowHiddenImage : UIImageView!
    
    @IBOutlet weak var activityView : UIView!
    @IBOutlet weak var activityIndicatorView : UIActivityIndicatorView!
    
    private var authentication : Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authentication = Authentication()
        
        configureNotificationKeyboards()
        configureTextFields()
    }

    private func showPasswordInfo() {
        let passwordInfoMessage : String =
        """
            Use the next criterias for setting your password:
            * (8-32 characters with no space)
            * uppercase letter (A-Z)
            * digit (0-9)
            * special character (e.g. !@#$%^)
        """
        
        let alertController = UIAlertController(title: "Password Info", message: passwordInfoMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertAction)
        
        self.navigationController?.present(alertController, animated: true)
    }
    
    private func changeSecureTextEntry(isPassword: Bool) {
        
        guard let currentTextField = isPassword ? passwordTF : rePasswordTF,
        let currentShowHiddenImage = isPassword ? passShowHiddenImage : rePassShowHiddenImage
        else { return }
        
        currentTextField.isSecureTextEntry = !currentTextField.isSecureTextEntry
        
        var imageSystemName : String = ""
        
        if(currentTextField.isSecureTextEntry) {
            imageSystemName = "eye.slash.fill"
        } else {
            imageSystemName = "eye.fill"
        }
        
        currentShowHiddenImage.image = UIImage(systemName: imageSystemName)
    }
    
    private func configureTextFields() {
        emailTF.delegate = self
        passwordTF.delegate = self
        rePasswordTF.delegate = self
        
        emailTF.tag = 1
        passwordTF.tag = 2
        rePasswordTF.tag = 3
    }
    
    private func showHiddenLoader() {
        activityView.isHidden = !activityView.isHidden
        
        activityIndicatorView.isAnimating ? activityIndicatorView.stopAnimating() :
            activityIndicatorView.startAnimating()
    }
    
    override func changeTextField() {
        super.changeTextField()
        
        guard let authController = authentication else { return }
        
        let isAuth : Bool = authController.authenticationRegister(
            email: emailTF.text ?? "",
            password: passwordTF.text ?? "",
            rePassword: rePasswordTF.text ?? "")
        
        registerBtn.isEnabled = isAuth 
        
        registerBtn.backgroundColor = isAuth ? .white : .lightGray
    }
    
    @IBAction func passwordInfoButtonPressed() {
        showPasswordInfo()
    }
    
    @IBAction func showHiddenPasswordButtonPressed() {
        changeSecureTextEntry(isPassword: true)
    }
    
    @IBAction func showHiddenRePasswordButtonPressed() {
        changeSecureTextEntry(isPassword: false)
    }
    
    @IBAction func registerButtonPressed() {
        showHiddenLoader()
    }
    
    @IBAction func signinButtonPressed() {
        let vc = LoginViewController.instantiateFromNib()
        transitionWithAnimation(to: vc)
    }
}
