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

class CheckInViewController: UIViewController, CLLocationManagerDelegate {
   
   var locationManager:CLLocationManager = CLLocationManager()

   @IBOutlet weak var currentAltitude: UILabel!
   @IBOutlet weak var shareSwitch: UISwitch!
   
   let rootRef = FIRDatabase.database().reference()
   let user = FIRAuth.auth()?.currentUser
   
   @IBAction func settingChanged(_ sender: AnyObject) {

      
      if shareSwitch.isOn {
         rootRef.child((user?.displayName)!).child("Sharing").setValue("on")
      }
      else {
         rootRef.child((user?.displayName)!).child("Sharing").setValue("off")
      }

   }
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.locationManager = CLLocationManager()
      locationManager.requestWhenInUseAuthorization()
      self.locationManager.delegate = self
      self.locationManager.distanceFilter = kCLDistanceFilterNone
      self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
      self.locationManager.startUpdatingLocation()

    }
   
   
//   func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
//      var alt = newLocation.altitude
//      print("altitude!")
//      print("\(alt)")
//      
//      manager.stopUpdatingLocation()
//   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
      
      print("found altitude:", locations.last?.altitude)
      currentAltitude.text = String(format:"%f", abs((locations.last?.altitude.distance(to: 0))!))
      
      rootRef.child((user?.displayName)!).child("Location").setValue(currentAltitude.text)
      manager.stopUpdatingLocation()
      
      
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
