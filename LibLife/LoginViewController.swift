//
//  LoginViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/26/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

   @IBOutlet weak var username: UITextField!
   
   
   @IBOutlet weak var password: UITextField!
   
   
   @IBAction func createAccount(_ sender: AnyObject) {
      
     login()
      
   }
   
   
   func login() {
      
      FIRAuth.auth()?.signIn(withEmail: username.text!, password: password.text!, completion: {
         user, error in
         
         if error != nil {
            print("something went wrong!")
            self.displayError("Log in failed", "Username/password was incorrect. Please try again.")
         }
         else {
            print("logged in successfully!")

            
            
            self.performSegue(withIdentifier: "loginToMain", sender: nil)
         }
      })
      
      
   }
   
   func displayError(_ title: String, _ message: String) {
      let alertController = UIAlertController(title: title, message:
         message, preferredStyle: UIAlertControllerStyle.alert)
      alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
      
      self.present(alertController, animated: true, completion: nil)
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
