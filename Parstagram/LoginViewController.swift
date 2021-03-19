//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Ayon Paul on 3/13/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = userField.text
        user.password = passField.text
          user.email = "email@example.com"
          // other fields can be set just like with PFObject
        user.signUpInBackground { (success, error) in
            if success {
                //If a user successfuly signs up, then the app should perform the segue between loginview and feedview, un which feedview is embedded in a nav view controller that is connected to the loginview via present modally
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print("Error logging in: \( error?.localizedDescription)")
            }
        }
    }
    @IBAction func signIn(_ sender: Any) {
        let username = userField.text!
        let password = passField.text!
        PFUser.logInWithUsername(inBackground: username, password: password){(user, error) in
            //Can replace user, error with success, error: name isn't important, the bools are meant to be used to indicate segues or not
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print("Error logging in: \( error?.localizedDescription)")
            }
        }
    }
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
