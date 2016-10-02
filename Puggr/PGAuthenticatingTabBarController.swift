//
//  PGAuthenticatingTabBarController.swift
//  Puggr
//
//  Created by Michael Hulet on 10/1/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import FirebaseAuth

var presentOnce: Int = 0

class PGAuthenticatingTabBarController: UITabBarController{
    override func viewDidAppear(_ animated: Bool) -> Void{
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        if FIRAuth.auth()?.currentUser == nil{
            UIApplication.shared.delegate!.window!!.rootViewController!.present(UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PGAuthenticationFlow"), animated: false, completion: nil)
        }
    }
}
