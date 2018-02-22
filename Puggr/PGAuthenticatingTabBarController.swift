//
//  PGAuthenticatingTabBarController.swift
//  Puggr
//
//  Created by Michael Hulet on 10/1/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import FirebaseAuth

class PGAuthenticatingNavigationController: UINavigationController{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    override func viewDidAppear(_ animated: Bool) -> Void{
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        if Auth.auth().currentUser == nil{
            present(UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PGAuthenticationFlow"), animated: false, completion: nil)
        }
    }
}
