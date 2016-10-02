//
//  PGSignUpViewController.swift
//  Puggr
//
//  Created by Michael Hulet on 10/1/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import FirebaseAuth

class PGSignUpViewController: UIViewController{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    override func viewDidLoad() -> Void{
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() -> Void{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUp() -> Void{
        if passwordField.text == confirmPasswordField.text{
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error: Error?) in
                if error == nil && user != nil{
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
}
