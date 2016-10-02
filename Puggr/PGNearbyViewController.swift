//
//  FirstViewController.swift
//  Puggr
//
//  Created by Michael Hulet on 9/30/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PGNearbyViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() -> Void{
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(addNewLocation(_:)))
        map.addGestureRecognizer(recognizer)
        let header = #imageLiteral(resourceName: "logo")
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: header.size.width, height: header.size.height))
        logoView.image = header
        navigationItem.titleView = logoView
        if let name = FIRAuth.auth()?.currentUser?.displayName, !name.contains(" "){
            let change = FIRAuth.auth()?.currentUser?.profileChangeRequest()
            switch FIRAuth.auth()!.currentUser!.email!{
                case "mhuletdev@gmail.com":
                    change?.displayName = "Michael Hulet"
                case "egrisso1@vols.utk.edu":
                    change?.displayName = "Ethan Grissom"
                case "glowingpandaproductions@gmail.com":
                    change?.displayName = "Bryson Landsford"
                case "dbdatbui@gmail.com":
                    change?.displayName = "Dat Bui"
                default:
                    change?.displayName = FIRAuth.auth()!.currentUser!.email!
            }
            change?.commitChanges(completion: nil)
        }
        db.child("events").observe(.value) { (snapshot: FIRDataSnapshot) in
            let data = snapshot.value as! [String: [String: Any]]
            for (_, info) in data{
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: info["latitude"]! as! Double, longitude: info["longitude"]! as! Double)
                annotation.title = (info["activity"]! as! String) + " with " + (info["owner"]! as! String)
                let people = info["people"]! as! Int
                if people == 0{
                    annotation.subtitle = "Anybody can come!"
                }
                else{
                    annotation.subtitle = "Needs \(info["people"]! as! Int) people"
                }
                var shouldAdd = true
                for pin in self.map.annotations{
                    if pin.coordinate.longitude == annotation.coordinate.longitude && pin.coordinate.latitude == annotation.coordinate.latitude{
                        shouldAdd = false
                        break
                    }
                }
                if shouldAdd{
                    self.map.addAnnotation(annotation)

                }
            }
        }
    }

    @objc func addNewLocation(_ gestureRecognizer: UILongPressGestureRecognizer) -> Void{
        if gestureRecognizer.state == .began{
            let annotation = MKPointAnnotation()
            annotation.coordinate = map.convert(gestureRecognizer.location(in: map), toCoordinateFrom: map)
            annotation.title = "New Activity"
            map.addAnnotation(annotation)
            let eventConfigurator = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "New Event") as! PGNewEventViewController
            eventConfigurator.point = annotation
            navigationController?.pushViewController(eventConfigurator, animated: true)
        }
    }

    func mapView(_ view: MKMapView, didUpdate location: MKUserLocation) -> Void{
        map.setCenter(location.coordinate, animated: true)
        map.setRegion(MKCoordinateRegionMake(location.coordinate, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation.coordinate != map.userLocation.coordinate{
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.pinTintColor = .red
            pin.animatesDrop = true
            pin.isDraggable = true
            pin.canShowCallout = true
            return pin
        }
        return nil
    }
}

extension CLLocationCoordinate2D: Equatable{
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool{
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
