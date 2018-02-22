//
//  SecondViewController.swift
//  Puggr
//
//  Created by Michael Hulet on 9/30/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import FirebaseAuth

class PGProfileViewController: UIViewController{
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    override func viewWillAppear(_ animated: Bool) -> Void{
        super.viewWillAppear(animated)
        print("TEST: \(profilePictureView)")
        print("TEST: \(nameField)")
        profilePictureView.layer.cornerRadius = profilePictureView.frame.width / 2
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.masksToBounds = true
        profilePictureView.layer.borderWidth = 1
        profilePictureView.image = UIImage(named: Auth.auth().currentUser!.email!)
        print(profilePictureView.frame)
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = #colorLiteral(red: 0.9450980392, green: 0.5647058824, blue: 0.5254901961, alpha: 1).cgColor
        border.frame = CGRect(x: 0, y: nameField.frame.size.height - width, width:  nameField.frame.size.width, height: nameField.frame.size.height)
        nameField.text = Auth.auth().currentUser!.displayName!
        border.borderWidth = width
        nameField.layer.addSublayer(border)
        nameField.layer.masksToBounds = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    @IBAction func dismiss() -> Void{
        dismiss(animated: true, completion: nil)
    }

}
