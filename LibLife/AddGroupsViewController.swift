//
//  AddGroupsViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/20/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class AddGroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   
   @IBOutlet weak var tableView: UITableView!
   
   
   @IBOutlet weak var groupName: UITextField!
   
   
   var friends: [Friend] = []
   
   var selectedFriends: [Friend] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      //friends += [Friend(name: "TestFriend1", userID: 9999), Friend(name: "TestFriend2", userID: 9999),Friend(name: "TestFriend3", userID: 9999)]
      loadFriends()
   }
   
   func loadFriends(){
      
      let user = FIRAuth.auth()?.currentUser
      let rootRef = FIRDatabase.database().reference()
      
      
      rootRef.child((user?.displayName)!).child("Friends").observeSingleEvent(of: .value, with: { (snapshot) in
         
         for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
            
            self.friends += [Friend(name: rest.value! as! String, userID: 9999)]
         }
         
         self.tableView.reloadData()
      })
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      print(friends.count)
      return friends.count
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if selectedFriends.contains(friends[indexPath.row]) == false {
         selectedFriends += [friends[indexPath.row]]
         print("***" , friends[indexPath.row].name)
      }
      else {
         selectedFriends.remove(at: selectedFriends.index(of: friends[indexPath.row])!)
      }
      
      self.tableView.reloadData()
      
      /*
      print("****")
      for f in selectedFriends {
         print(f.name)
      }
 */
      
   }
   

   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellChooseFriends", for: indexPath) as! ChooseFriendsTableViewCell
      
      cell.name.text = friends[indexPath.row].name
      
      //print(cell.name.text)
      
      if selectedFriends.contains(friends[indexPath.row]) {
         cell.accessoryType = UITableViewCellAccessoryType.checkmark

      }
      else {
         cell.accessoryType = UITableViewCellAccessoryType.none
         
      }
      
      return cell
   }
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if selectedFriends.count > 0 {
         
         let destVC = segue.destination as? MyGroupsViewController
         
         destVC?.groups += [Group(name: groupName.text!, members: selectedFriends)]
         
         let user = FIRAuth.auth()?.currentUser
         let rootRef = FIRDatabase.database().reference()
         
         //adding groups to database
         
         for friend in selectedFriends {
            rootRef.child((user?.displayName)!).child("Groups").child(groupName.text!).childByAutoId().setValue(friend.name)
         }
         
      }
      else {
         //TO DO: display error message
      }

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
