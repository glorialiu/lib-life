//
//  Friend.swift
//  LibLife
//
//  Created by Gloria Liu on 11/19/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import Foundation

class Friend: Equatable {
   
   var name: String
   var userID: Int
   var floor: Int?
   
   init(name: String, userID: Int) {
      self.name = name
      self.userID = userID
   }
   
   static func == (lhs: Friend, rhs: Friend) -> Bool {
      return lhs.name == rhs.name && lhs.userID == rhs.userID
   }
   
   
   
}
