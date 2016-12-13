//
//  FriendLocViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 12/5/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class FriendLocViewController: UIViewController {

   var curFriend: Friend? = nil
   
   @IBOutlet weak var friendName: UILabel!
   
   @IBOutlet weak var mapView: MKMapView!
   
   @IBOutlet weak var floor: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

      let thisFriendsName = curFriend?.name
      friendName.text = curFriend?.name
      mapView.mapType = MKMapType.satellite
      let centralLocation = CLLocation(latitude: 35.301871, longitude: -120.663856)
      centerMapOnLocation(location: centralLocation)
      
      let user = FIRAuth.auth()?.currentUser
      let rootRef = FIRDatabase.database().reference()
      
      
      rootRef.child((user?.displayName)!).child("Friends").observeSingleEvent(of: .value, with: { (snapshot) in
         
         for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
            
            if thisFriendsName == rest.value! as! String {
               
               rootRef.child(thisFriendsName!).child("Sharing").observeSingleEvent(of: .value, with: { (snapshot) in
                  if snapshot.value! as! String == "on" {
                     self.loadFriendInfo()
                  }
                  else {
                     self.notSharing()
                  }
               })
               
               
            }
            //self.friends += [Friend(name: rest.value! as! String, userID: 9999)]
         }
         
         //self.tableview.reloadData()
      })
      
      


      
      //rootRef.child((user?.displayName)!).child("latitude").setValue(35.301871)
      //rootRef.child((user?.displayName)!).child("longitude").setValue(-120.663856)
      
        // Do any additional setup after loading the view.
    }
   
   func notSharing() {
      floor.text = "Not sharing"
   }
   
   func loadFriendInfo() {
      
      let ref = FIRDatabase.database().reference().child((curFriend?.name)!).child("longitude")
      ref.observe(.value, with: {snapshot in
         let longtitude = snapshot.value!
         
         let ref2 = FIRDatabase.database().reference().child((self.curFriend?.name)!).child("latitude")
         ref2.observe(.value, with: {snapshot in
            let latitude = snapshot.value!
            
            let friend = ActiveFriend(name: (self.curFriend?.name)!, coordinate: CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longtitude as! CLLocationDegrees))
            
            self.mapView.addAnnotation(friend)
         })
      })
      
      let ref3 = FIRDatabase.database().reference().child((curFriend?.name)!).child("altitude")
      
      ref3.observe(.value, with: { snapshot in
         
         let altitude = snapshot.value!
         print(altitude)
         self.floor.text = self.altToFloor(altitude: (altitude as! NSString).doubleValue)
         
         
         
      })
   }
   
   func altToFloor(altitude: Double) -> String {
      
      if altitude < 80 {
         return "5"
      }
      else {
         return "1"
      }
      
      
   }

   let regionRadius: CLLocationDistance = 75
   func centerMapOnLocation(location: CLLocation) {
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
      mapView.setRegion(coordinateRegion, animated: true)
   }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
