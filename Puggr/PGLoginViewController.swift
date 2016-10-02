//
//  PGLoginViewController.swift
//  Puggr
//
//  Created by Michael Hulet on 10/1/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreLocation

class PGLoginViewController: UIViewController{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() -> Void{
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() -> Void{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func authenticate() -> Void{
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: {(user: FIRUser?, error: Error?) in
            if error == nil && user != nil{
                if CLLocationManager.authorizationStatus() != .authorizedAlways{
                    CLLocationManager().requestWhenInUseAuthorization()
                }
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        })
    }
}
