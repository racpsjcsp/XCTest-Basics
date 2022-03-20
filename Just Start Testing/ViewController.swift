//
//  ViewController.swift
//  Just Start Testing Tests
//
//  Created by Rafael Plinio on 19/03/22.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyDatabase = [User(username: "rafa test", password: "password 1")]
    
    private let validation: ValidationService
    
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        do {
            let username = try validation.validateUsername(username: usernameTextField.text)
            let password = try validation.validatePassword(password: passwordTextField.text)

            // Login to database...
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == user.password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
                
            } else {
                throw LoginError.invalidCredentials
            }
            
        } catch {
            present(error)
        }
    }
}
