//
//  PGNewEventViewController.swift
//  Puggr
//
//  Created by Michael Hulet on 10/2/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import MapKit

class PGNewEventViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var attendanceStepper: UIStepper!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var point: MKAnnotation!
    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceStepper.maximumValue = Double.infinity
        // Do any additional setup after loading the view.
        map.addAnnotation(point)
        map.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        map.layer.borderWidth = 1
        map.layer.cornerRadius = 10
        map.setCenter(point.coordinate, animated: false)
        map.setRegion(MKCoordinateRegionMake(point.coordinate, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: false)
        saveButton.layer.borderColor = saveButton.titleColor(for: .normal)?.cgColor
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 3
        saveButton.isEnabled = false
        activityField.delegate = self
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation.coordinate != map.userLocation.coordinate{
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.pinTintColor = .red
            pin.animatesDrop = true
            pin.isDraggable = true
            pin.canShowCallout = false
            return pin
        }
        return nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        activityField.resignFirstResponder()
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        saveButton.isEnabled = !(string == "" && textField.text?.characters.count == 1)
        return true
    }

    @IBAction func attendanceChanged() -> Void{
        guard attendanceStepper.value != 0 else{
            attendanceLabel.text = "As many as possible"
            return
        }
        attendanceLabel.text = "\(Int(attendanceStepper.value))"
    }

    @IBAction func saveEvent() -> Void{
        let owner: String
        switch Auth.auth().currentUser!.email!{
            case "mhuletdev@gmail.com":
                owner = "Michael Hulet"
            case "egrisso1@vols.utk.edu":
                owner = "Ethan Grissom"
            case "glowingpandaproductions@gmail.com":
                owner = "Bryson Landsford"
            case "dbdatbui@gmail.com":
                owner = "Dat Bui"
            default:
                owner = Auth.auth().currentUser!.email!
        }
        db.child("events").childByAutoId().setValue(["latitude": point.coordinate.latitude, "longitude": point.coordinate.longitude, "activity": activityField.text!, "people": attendanceStepper.value, "owner": owner])
        let _ = navigationController?.popViewController(animated: true)
    }
}
