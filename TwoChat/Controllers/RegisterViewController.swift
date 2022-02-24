//
//  RegisterViewController.swift
//  TwoChat
//
//  Created by Асхат Баймуканов on 24.02.2022.
//


import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //if let - checking the optionals
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Message", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    //Add an alert action
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    //Show the alert
                    self.present(alert, animated: true, completion: nil)
                } else {
                    //Navigate to the ChatViewController using segue RegisterToChat
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
    }
}
