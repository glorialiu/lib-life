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
   
    override func viewDidLoad() {
        super.viewDidLoad()

      friendName.text = curFriend?.name
      mapView.mapType = MKMapType.satellite
      let centralLocation = CLLocation(latitude: 35.301871, longitude: -120.663856)
      centerMapOnLocation(location: centralLocation)
      
      
 
      //print("longtitude is ", ref.value(forKey: "longitude"))
      //let user = FIRAuth.auth()?.currentUser
      let ref = FIRDatabase.database().reference().child((curFriend?.name)!).child("longitude")
      
      ref.observe(.value, with: {snapshot in
         //print("longtitude is :", snapshot.value!)
         let longtitude = snapshot.value!

         let ref2 = FIRDatabase.database().reference().child((self.curFriend?.name)!).child("latitude")
         ref2.observe(.value, with: {snapshot in
            //print("latitude is :", snapshot.value!)
            let latitude = snapshot.value!
            
            
            let friend = ActiveFriend(name: (self.curFriend?.name)!, coordinate: CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longtitude as! CLLocationDegrees))
            
            self.mapView.addAnnotation(friend)
         })
         

         
         
      })
      

      
      //rootRef.child((user?.displayName)!).child("latitude").setValue(35.301871)
      //rootRef.child((user?.displayName)!).child("longitude").setValue(-120.663856)
      
        // Do any additional setup after loading the view.
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
