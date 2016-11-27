//
//  CreateAccountViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/26/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

   

   @IBOutlet weak var username: UITextField!
   @IBOutlet weak var displayName: UITextField!
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var password: UITextField!
   @IBOutlet weak var confirmPassword: UITextField!
   

   @IBAction func createAccount(_ sender: AnyObject) {
      
      if password.text! != confirmPassword.text! {
         let title = "There were one or more issues!"
         let message = "Passwords do not match. Please fix this."
        
         displayError(title, message)
         return
      }
      
      if ((displayName.text?.isEmpty)!) {
         let title = "There were one or more issues!"
         let message = "Please enter a display name."
         
         displayError(title, message)
         return
      }
      
      usernameExists()
      
      
//      rootRef.queryOrdered(byChild: )
//      rootRef.queryOrderedByChild("waiting").queryEqualToValue("1")
//         .observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            if !snapshot.exists() {
//               print("test2")
//            }
//         });
//      
      
      FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {
         user, error in
         
         if error != nil {
            self.displayError("There was an issue.", "This account already exists or there was a problem with your email.")
            
         }
         else {
            print("User created with email \(self.email.text!)")
            
            
            self.login()
         }
      })
      
   }
   
   func usernameExists() {
      let rootRef = FIRDatabase.database().reference()
      
      rootRef.observeSingleEvent(of: .value, with: { (snapshot) in
         
         if snapshot.hasChild(self.username.text!){
            
            print("this username exists")
            self.displayError("Oops!", "That username already exists.")
            return
            
         }else{
            
            print("this username doesn't exist")
            
         }
         
         
      })
      
//      rootRef.queryOrdered(byChild: "email").queryEqual(toValue: email.text!).observeSingleEvent(of: .value, with: { (snapshot) in
//         if snapshot.exists() {
//            print("This email exists!!!")
//            self.email.backgroundColor = .green
//            return
//         }
//         else {
//            self.email.backgroundColor = .red
//            print("This email does not exist")
//         }
//      })
   }
   
   
   func login() {
      
      FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
         user, error in
         
         if error != nil {
            print("something went wrong!")
            
         }
         else {
            print("logged in successfully!")
            
            
            
            // set display name
            let user = FIRAuth.auth()?.currentUser
            if let user = user {
               let changeRequest = user.profileChangeRequest()
               
               changeRequest.displayName = self.username.text!

               changeRequest.commitChanges { error in
                  if let _ = error {
                     // An error happened.
                     print("there was an error here")
                  } else {
                     // Profile updated.
                     print("profile updated successfully")
                     print("user name is :", user.displayName)
                     
                     self.post(displayName: user.displayName!, email: user.email!)
                     
                     self.performSegue(withIdentifier: "createAccountToMain", sender: nil)
                  }
               }
            }
            

         }
         
         
         
         
      })
      
      
   }
   
   func post(displayName: String, email: String) {
      
      let userStatus : [String:String] = ["displayName": displayName,
                                    "email": email]
      let databaseRef = FIRDatabase.database().reference()
      
      //databaseRef.child("Posts").childByAutoId().setValue(post)
      databaseRef.child(username.text!).setValue(userStatus)
   }
   
   func displayError(_ title: String, _ message: String) {
      let alertController = UIAlertController(title: title, message:
         message, preferredStyle: UIAlertControllerStyle.alert)
      alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
      
      self.present(alertController, animated: true, completion: nil)
   }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.dismissKeyboard))

      
      view.addGestureRecognizer(tap)
      
        // Do any additional setup after loading the view.
    }

   func dismissKeyboard() {
      //Causes the view (or one of its embedded text fields) to resign the first responder status.
      view.endEditing(true)
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
