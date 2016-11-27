//
//  Group.swift
//  LibLife
//
//  Created by Gloria Liu on 11/20/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import Foundation

class Group {
   
   var name: String
   var members: [Friend]
   
   init(name: String, members: [Friend]) {
      self.name = name
      self.members = members
   }
   
   
}
