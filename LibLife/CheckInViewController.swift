//
//  CheckInViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/26/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

class CheckInViewController: UIViewController, CLLocationManagerDelegate {
   
   var locationManager:CLLocationManager = CLLocationManager()

   @IBOutlet weak var currentAltitude: UILabel!
   @IBOutlet weak var shareSwitch: UISwitch!
   
   @IBOutlet weak var updateLocationButton: UIButton!
   @IBOutlet weak var mapView: MKMapView!
   let rootRef = FIRDatabase.database().reference()
   let user = FIRAuth.auth()?.currentUser
   
   @IBAction func settingChanged(_ sender: AnyObject) {

      
      if shareSwitch.isOn {
         
         if (currentAltitude.text != " ") {
            rootRef.child((user?.displayName)!).child("Sharing").setValue("on")
            
            let pink = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 150.0/255.0, alpha: 1)
            
            updateLocationButton.backgroundColor = pink
         }
         else {
            shareSwitch.isOn = false
         }
         

         
         
      }
      else {
         rootRef.child((user?.displayName)!).child("Sharing").setValue("off")
         updateLocationButton.backgroundColor = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 150.0/255.0, alpha: 0.5)
      }

   }
   
   @IBAction func updateLocation(_ sender: AnyObject) {
      
      
      
      
      
   }

   
    override func viewDidLoad() {
        super.viewDidLoad()
      mapView.mapType = MKMapType.satellite
      
      self.locationManager = CLLocationManager()
      locationManager.requestWhenInUseAuthorization()
      self.locationManager.delegate = self
      self.locationManager.distanceFilter = kCLDistanceFilterNone
      self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
      
      
      //self.locationManager.location?.coordinate
      
      self.locationManager.startUpdatingLocation()
      //let initialLocation = CLLocation(latitude: 35.302114, longitude: -120.664509)
      //uncomment this when looking for
      let initialLocation = self.locationManager.location!

      let centralLocation = CLLocation(latitude: 35.301871, longitude: -120.663856)
      
      
      
      centerMapOnLocation(location: centralLocation)
      
      //check if they are actually in the library!
      //northeast corner 35.302324, -120.663392
      //northwest corner 35.302114, -120.664509
      //southwest corner 35.301343, -120.664273
      //southeast corner 35.301540, -120.663147
      if (initialLocation.coordinate.latitude <= 35.302114) &&
         (initialLocation.coordinate.latitude >= 35.301540) &&
         (initialLocation.coordinate.longitude <= -120.663147) &&
         (initialLocation.coordinate.longitude >=  -120.664509) {
         
         //let friend = ActiveFriend(name: "Sarah", coordinate: CLLocationCoordinate2D(latitude: 35.302324, longitude: -120.663392))
         let me = ActiveFriend(name: "me", coordinate: initialLocation.coordinate)
         
         //mapView.addAnnotation(friend)
         mapView.addAnnotation(me)
         
         let rootRef = FIRDatabase.database().reference()
         let user = FIRAuth.auth()?.currentUser
         
         rootRef.child((user?.displayName)!).child("latitude").setValue(initialLocation.coordinate.latitude)
         rootRef.child((user?.displayName)!).child("longitude").setValue(initialLocation.coordinate.longitude)
         
         print("values set!!!")
      }
      else {
         rootRef.child((user?.displayName)!).child("Sharing").setValue("off")
         shareSwitch.isOn = false
         print("NOT IN LIBRARY")
         currentAltitude.text = ""
      }
      


      

    }
   
   
//   func pinColor() -> MKPinAnnotationColor  {
//      switch title! {
//      case "me":
//         return .red
//      default:
//         return .purple
//      }
//   }
   
   let regionRadius: CLLocationDistance = 75
   func centerMapOnLocation(location: CLLocation) {
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
      mapView.setRegion(coordinateRegion, animated: true)
   }
   
   
//   func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
//      var alt = newLocation.altitude
//      print("altitude!")
//      print("\(alt)")
//      
//      manager.stopUpdatingLocation()
//   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
      
      //print("found altitude:", locations.last?.altitude)
      //currentAltitude.text = String(format:"%f", abs((locations.last?.altitude.distance(to: 0))!))
      
      currentAltitude.text = altToFloor(altitude: abs((locations.last?.altitude.distance(to: 0))!))
      
      rootRef.child((user?.displayName)!).child("altitude").setValue(currentAltitude.text)
      manager.stopUpdatingLocation()
      
      
   }
   
   func altToFloor(altitude: Double) -> String {
      
      if altitude == 0 {
         return " "
      }
      else if altitude < 98 {
         return "1"
      }
      else if (altitude < 101) {
         return "2"
      }
      else if (altitude < 105) {
         return "3"
      }
      else if (altitude < 109) {
         return "4"
      }
      else {
         return "5"
      }

   }
   
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
      
   }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
