//
//  CheckInViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/26/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class CheckInViewController: UIViewController {

   @IBOutlet weak var shareSwitch: UISwitch!
   
   @IBAction func settingChanged(_ sender: AnyObject) {
      let rootRef = FIRDatabase.database().reference()
      let user = FIRAuth.auth()?.currentUser
      
      if shareSwitch.isOn {
         rootRef.child((user?.displayName)!).child("Sharing").setValue("on")
      }
      else {
         rootRef.child((user?.displayName)!).child("Sharing").setValue("off")
      }


      
      
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
      
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
