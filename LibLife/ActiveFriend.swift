//
//  ActiveFriend.swift
//  LibLife
//
//  Created by Gloria Liu on 12/5/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import Foundation
import MapKit

class ActiveFriend: NSObject, MKAnnotation {
   let name: String?
   let coordinate: CLLocationCoordinate2D
   
   init(name: String, coordinate: CLLocationCoordinate2D) {
      self.name = name
      self.coordinate = coordinate
      
      super.init()
   }
   
   var title: String? {
      return name
   }
}
