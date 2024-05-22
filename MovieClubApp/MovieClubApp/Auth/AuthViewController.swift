//
//  AuthViewController.swift
//  MovieClubApp
//
//  Created by viciecal on 21/05/2024.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var btnLogin : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func LoginBtnPressed() {
        
        let loginVC = LoginViewController()
        
        navigationController?.pushViewController(loginVC, animated: true)
    }

}
