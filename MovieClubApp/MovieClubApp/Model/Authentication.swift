//
//  Authentication.swift
//  MovieClubApp
//
//  Created by Alexis Vaglica on 23/05/2024.
//

import Foundation

struct Authentication {
    private let minPassLenght : Int16 = 8
    private let maxPassLenght : Int16 = 32
    
    func authenticationAccount(email: String, password: String) -> Bool {
        
        guard !email.isEmpty && !password.isEmpty else {
            return false
        }
        
        return authEmail(email) && authPassword(password)
    }
    
    func authenticationRegister(email: String, password: String, rePassword: String) -> Bool {
        
        guard !email.isEmpty && 
                !password.isEmpty &&
                !rePassword.isEmpty &&
                password == rePassword
        else { return false }
        
        return authEmail(email) && authPassword(password) && authPassword(rePassword)
    }
    
    private func authEmail(_ email: String) -> Bool {
        return containEmailDirection(email)
    }
    
    private func authPassword(_ password: String) -> Bool {
        return containCorrectLenght(password) &&
                containUppercase(password) &&
                containDigit(password) &&
                containSpecialCharacter(password)
    }
}

extension Authentication {
    func containEmailDirection(_ email: String) -> Bool {
        return email.range(of: "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}", options: .regularExpression) != nil
    }
}

extension Authentication {
    private func lenghtCriteria(_ password: String) -> Bool {
        return password.count >= minPassLenght &&
                password.count <= maxPassLenght
    }
    
    private func notWhitespaceCriteria(_ password: String) -> Bool {
        return password.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    private func containCorrectLenght(_ password: String) -> Bool {
        return lenghtCriteria(password) && notWhitespaceCriteria(password)
    }
    
    private func containUppercase(_ password: String) -> Bool {
        return password.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    private func containDigit(_ password: String) -> Bool {
        return password.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    private func containSpecialCharacter(_ password: String) -> Bool {
        return password.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil
    }
}
