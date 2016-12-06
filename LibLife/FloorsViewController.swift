//
//  FloorsViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/27/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit

class FloorsViewController: UIViewController {

   @IBOutlet weak var floorSelector: UISegmentedControl!
   
   var firstFloorFriends: [Friend] = []
   var secondFloorFriends: [Friend] = []
   var thirdFloorFriends: [Friend] = []
   var fourthFloorFriends: [Friend] = []
   var fifthFloorFriends: [Friend] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func floorChanged(_ sender: AnyObject) {
      
      //floorSelector.selectedSegmentIndex
      //floorSelector
      
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
