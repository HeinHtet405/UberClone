//
//  ViewController.swift
//  UberClone
//
//  Created by Hein Htet on 9/18/17.
//  Copyright © 2017 Hein Htet. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var riderDriverSwitchBtn: UISwitch!
    @IBOutlet weak var riderLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        if emailTextField.text == "" || passwordTextField.text == ""  {
            displayAlert(title: "Missing Information", message: "You must provide both a email and password")
        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    if signUpMode {
                        // SIGN UP
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            }else {
                                print("Sign Up Success")
                            }
                        })
                    }else {
                        // LOG IN
                        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            }else {
                                print("Login Success")
                            }
                        })
                    }
                }
            }
        }
    }
    
    func displayAlert(title:String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if signUpMode {
          signupBtn.setTitle("Log In", for: .normal)
            loginBtn.setTitle("Switch to Sign Up", for: .normal)
            riderLabel.isHidden = true
            driverLabel.isHidden = true
            riderDriverSwitchBtn.isHidden = true
            signUpMode = false
        } else {
            signupBtn.setTitle("Sign Up", for: .normal)
            loginBtn.setTitle("Switch to Log In", for: .normal)
            riderLabel.isHidden = false
            driverLabel.isHidden = false
            riderDriverSwitchBtn.isHidden = false
            signUpMode = true
        }
    }
    
}

