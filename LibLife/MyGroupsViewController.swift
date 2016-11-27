//
//  MyGroupsViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/20/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class MyGroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   @IBOutlet weak var tableview: UITableView!
   
   var groups: [Group] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

      loadGroups()
        // Do any additional setup after loading the view.
      print(groups.count)
    }

   func loadGroups() {
      //groups += [Group(name: "CPE Friends", members: [Friend(name: "Gloria", userID: 1999), Friend(name: "Mady", userID: 20001)]), Group(name: "Roommates", members: [Friend(name: "lol", userID: 1999), Friend(name: "Hi", userID: 20001)])]
      
      let user = FIRAuth.auth()?.currentUser
      let rootRef = FIRDatabase.database().reference()
      
      
      rootRef.child((user?.displayName)!).child("Groups").observeSingleEvent(of: .value, with: { (snapshot) in
         
         for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
            
            var newGroup = Group(name: rest.key, members: [])
            
            for rest2 in rest.children.allObjects as! [FIRDataSnapshot] {
               newGroup.members += [Friend(name: rest2.value! as! String, userID: 9999)]
            }
            
            self.groups += [newGroup]
            
            //self.friends += [Friend(name: rest.value! as! String, userID: 9999)]
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
      return groups.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellGroup", for: indexPath) as! GroupTableViewCell
      let group = groups[indexPath.row]
      
      cell.groupNameLabel.text = group.name
      print(cell)
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      //this segue call is repetitive 
      //performSegue(withIdentifier: "groupsToGroupsDetail", sender: groups[indexPath.row])
   }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let destVC = segue.destination as? GroupsDetailViewController
      
      let selectedIndexPath = tableview.indexPathForSelectedRow
      destVC?.thisGroup = groups[(selectedIndexPath?.row)!]
      
      
   }
   
   @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
      tableview.reloadData()
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
