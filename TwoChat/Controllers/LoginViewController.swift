//
//  LoginViewController.swift
//  TwoChat
//
//  Created by Асхат Баймуканов on 25.02.2022.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    let alert = UIAlertController(title: "Message", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    //Add an alert action
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    //Show the alert
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
            }
        }
    }
}
