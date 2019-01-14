//
//  LoginVC.swift
//  SwiftFirebaseStarter
//
//  Created by MacBook on 1/14/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let listener = Auth.auth().addStateDidChangeListener {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginToFoodMain", sender: nil)
            }
        }
        Auth.auth().removeStateDidChangeListener(listener)
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if(error != nil){
                print(error?.localizedDescription ?? "error")
            }
            if(user != nil){
                self.performSegue(withIdentifier: "loginToFoodMain", sender: nil)
            }
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {
                                            (user, error) in
                                            if(error != nil){
                                                if let errorCode = AuthErrorCode(rawValue: error!._code){
                                                    switch errorCode{
                                                    case .weakPassword:
                                                        print("password is weak")
                                                        
                                                    default:
                                                        print("error")
                                                        
                                                    }
                                                }
                                            }
                                            
                                            if user != nil{
                                                user?.sendEmailVerification(completion: { (error) in
                                                    print(error?.localizedDescription ?? "")
                                                })
                                                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                                                    
                                                    if(error != nil){
                                                        print(error?.localizedDescription ?? "")
                                                    }
                                                    if(user != nil){
                                                        self.performSegue(withIdentifier: "loginToFoodMain", sender: nil)
                                                    }
                                                }
                                            }
                                        })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}


