//
//  MyFriendsViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/19/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class MyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
   @IBOutlet weak var tableview: UITableView!
   
   var friends: [Friend] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

      welcomeMessage()

      loadFriends()
      
//      for friend in friends {
//         print(friend.name)
//      }

      self.tableview.reloadData()

    }
   
   func getUserEmail() -> String? {
      if let user = FIRAuth.auth()?.currentUser {
         //let name = user.displayName
         let email = user.email
         //let photoUrl = user.photoURL
         //let uid = user.uid;  // The user's ID, unique to the Firebase project.
         // Do NOT use this value to authenticate with
         // your backend server, if you have one. Use
         // getTokenWithCompletion:completion: instead.
         return email
      } else {
         // No user is signed in.
      }
      return nil
   }
   
   func getUserDisplayName() -> String? {
      if let user = FIRAuth.auth()?.currentUser {
         let name = user.displayName
         return name
      } else {
         // No user is signed in.
      }
      return nil
   }
   
   func welcomeMessage() {
      
      if let email = getUserEmail() {
         let alertController = UIAlertController(title: "Welcome!", message:
            "You are logged in with \(email) and username \(getUserDisplayName()!)", preferredStyle: UIAlertControllerStyle.alert)
         alertController.addAction(UIAlertAction(title: "Thanks!", style: UIAlertActionStyle.default,handler: nil))
         
         self.present(alertController, animated: true, completion: nil)
      }
      
   }
   
   
   func loadFriends(){
      
      let user = FIRAuth.auth()?.currentUser
      let rootRef = FIRDatabase.database().reference()

      
      rootRef.child((user?.displayName)!).child("Friends").observeSingleEvent(of: .value, with: { (snapshot) in
         
         for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {

            self.friends += [Friend(name: rest.value! as! String, userID: 9999)]
         }
         
         self.tableview.reloadData()
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
      return friends.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellFriend", for: indexPath) as! FriendTableViewCell
      let friend = friends[indexPath.row]
      
      cell.name.text = friend.name
      
      return cell
   }
   
   @IBAction func logOut(_ sender: AnyObject) {
      try! FIRAuth.auth()!.signOut()
   }
   
   
   @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
      tableview.reloadData()
      
   }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      if (segue.identifier == "friendToDetailFriend") {
         let destVC = segue.destination as! FriendLocViewController
         
         destVC.curFriend = friends[(tableview.indexPathForSelectedRow?.row)!]
      }

      
      
    }


}
