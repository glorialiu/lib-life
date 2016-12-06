//
//  GroupsDetailViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/20/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit

class GroupsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var sharingSwitch: UISwitch!
   
   @IBOutlet weak var groupName: UILabel!
   
   var thisGroup: Group?
   @IBOutlet weak var tableView: UITableView!
   
   @IBAction func sharingChanged(_ sender: AnyObject) {
      
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      groupName?.text = thisGroup?.name
      
      //tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "cellFriend")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return (thisGroup?.members.count)!
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellFriend", for: indexPath) as! DisplayFriendTableViewCell
      

      
      cell.name.text = thisGroup?.members[indexPath.row].name
      
      return cell
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
