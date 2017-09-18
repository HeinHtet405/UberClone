//
//  ViewController.swift
//  UberClone
//
//  Created by Hein Htet on 9/18/17.
//  Copyright © 2017 Hein Htet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var riderDriverSwitchBtn: UISwitch!
    @IBOutlet weak var riderLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        print("SignUp Button Tapped")
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        print("Login Button Tapped")
    }
    
}

