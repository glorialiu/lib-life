//
//  FloorsViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/27/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class FloorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   @IBOutlet weak var tableview: UITableView!
   @IBOutlet weak var floorSelector: UISegmentedControl!
   
   var firstFloorFriends: [Friend] = []
   var secondFloorFriends: [Friend] = []
   var thirdFloorFriends: [Friend] = []
   var fourthFloorFriends: [Friend] = []
   var fifthFloorFriends: [Friend] = []
   
   var friends: [Friend] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      loadFriends()
      self.friends = self.thirdFloorFriends
      self.tableview.reloadData()
      
      print("num in friends:", friends.count)
      for friend in friends {
         print(friend.name)
      }
    }

   func loadFriends(){
      
      let user = FIRAuth.auth()?.currentUser
      let rootRef = FIRDatabase.database().reference()
      
      
      rootRef.child((user?.displayName)!).child("Friends").observeSingleEvent(of: .value, with: { (snapshot) in
         
         for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
            
            print("FOUND:", rest.value! as! String)
            self.loadFloor(rest.value! as! String)
            
            //self.friends += [Friend(name: rest.value! as! String, userID: 9999)]
         }
         
         
         
         print("num on third: ", self.thirdFloorFriends.count)
         for friend in self.thirdFloorFriends {
            print(friend.name)
         }
         
         self.friends = self.thirdFloorFriends
         self.tableview.reloadData()
         
         
      })
   }
   
   func loadFloor(_ name: String) {
      let ref = FIRDatabase.database().reference().child(name).child("Sharing")
      
      ref.observe(.value, with: { snapshot in
         
         if snapshot.value! as! String == "on" {
            
            let ref2 = FIRDatabase.database().reference().child(name).child("altitude")
            
            ref2.observe(.value, with: { snapshot in
               print("adding ", name, " to floor")
               self.addFloor(name: name, floor: snapshot.value! as! String)
            
            })
            
            self.friends = self.thirdFloorFriends
            self.tableview.reloadData()
            
            
         }
         
         
      })
      
   }
   
   func addFloor(name: String, floor: String) {
      
      let addFriend: Friend = Friend(name: name, userID: 9999)
      
      if floor == "1" {
         firstFloorFriends.append(addFriend)
      }
      else if floor == "2" {
         secondFloorFriends.append(addFriend)
      }
      else if floor == "3" {
         thirdFloorFriends.append(addFriend)
      }
      else if floor == "4" {
         fourthFloorFriends.append(addFriend)
      }
      else {
         fifthFloorFriends.append(addFriend)
      }
      print("***")
      for friend in thirdFloorFriends {
         print(friend.name)
      }
      self.friends = self.thirdFloorFriends
      self.tableview.reloadData()
      print("COUNT: ",friends.count)
      
   }
   
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   
   
   @IBAction func floorChanged(_ sender: AnyObject) {
      
      //floorSelector.selectedSegmentIndex
      //floorSelector
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return friends.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellFloor", for: indexPath) as! FloorTableViewCell
      
      
      let friend = friends[indexPath.row]
      
      cell.name.text = friend.name
      
      print("making cell with: ", friend.name)
      
      
      return cell
   }
   


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
      if (segue.identifier == "floorsToFriend") {
         let destVC = segue.destination as! FriendLocViewController
         
         destVC.curFriend = friends[(tableview.indexPathForSelectedRow?.row)!]
      }
      
    }


}
