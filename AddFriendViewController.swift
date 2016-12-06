//
//  AddFriendViewController.swift
//  LibLife
//
//  Created by Gloria Liu on 11/20/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit
import Firebase

class AddFriendViewController: UIViewController{
   
   var inputtedName: String?

   @IBOutlet weak var email: UITextField!
   
//   @IBOutlet weak var nameTextField: UILabel!
//
//   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//      nameTextField.text = textField.text
//      textField.resignFirstResponder()
//      inputtedName = textField.text
//      print(nameTextField.text)
//      return true
//   }
   
   @IBAction func donePressed(_ sender: AnyObject) {
      
   }
   

   @IBAction func cancelPressed(_ sender: AnyObject) {
      
   }
   
   @IBAction func validateFriend(_ sender: AnyObject) {
      let rootRef = FIRDatabase.database().reference()
      
      rootRef.observeSingleEvent(of: .value, with: { (snapshot) in
         
         if snapshot.hasChild(self.email.text!){
            
            print("this username exists")
            self.email.backgroundColor = .green
            
            
         }else{
            self.email.backgroundColor = .red
            print("this username doesn't exist")
            
         }
      })
      
      
   }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "doneAddingFriendSegue" {
         
         let destVC = segue.destination as? MyFriendsViewController
         
         
         if email.backgroundColor == .green {
            let rootRef = FIRDatabase.database().reference()
            
            rootRef.child(email.text!).observeSingleEvent(of: .value, with: { (snapshot) in
               // Get user value
               let value = snapshot.value as? NSDictionary
               let displayName = value?["displayName"] as? String ?? ""
               //let user = User.init(username: username)
               print("display name is ", displayName)
               
            }) { (error) in
               print(error.localizedDescription)
            }
            let user = FIRAuth.auth()?.currentUser
            
            rootRef.child((user?.displayName)!).child("Friends").childByAutoId().setValue(email.text!)
            
            
            
            destVC?.friends += [Friend(name: email.text!, userID: 9999)]
         }
         

      }
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
