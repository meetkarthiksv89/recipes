//
//  LoginViewController.swift
//  Recipes
//
//  Created by Karthik S V on 15/07/17.
//  Copyright © 2017 SV. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "login", sender: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLoginClicked(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("error")
            }
            else if result?.isCancelled == true {
                print("cancelled")
            }
            else{
                print("logged in")
                let crendentials = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(crendentials)
                //self.perform(<#T##aSelector: Selector!##Selector!#>)
            }
        }
    }
    func firebaseAuth(_ credentials: FIRAuthCredential)
    {
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil{
                print("error")
            }
            else{
                print("success")
                if let user = user {
                    let userData = ["provider":credentials.provider,"email":user.email!]
                    self.completeSignIn(uid: user.uid, userData: userData)
                }
            }
        })
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        if let email = email.text, let pwd = password.text{
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("signed in")
                    if let user = user {
                        let userData = ["provider":user.providerID,"email":user.email!]
                        self.completeSignIn(uid: user.uid, userData: userData)
                    }                }
                else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("unable to create user")
                        }
                        else {
                            print("user created")
                            
                            if let user = user {
                                let userData = ["provider":user.providerID,"email":user.email!]
                                self.completeSignIn(uid: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
        
        
    }
    
    func completeSignIn(uid: String, userData: Dictionary<String, String>){
        
        KeychainWrapper.standard.set(uid, forKey: KEY_UID)
        FirebaseManager.fm.createDatabaseUser(uid: uid, userData: userData)
        self.performSegue(withIdentifier: "login", sender: nil)
        
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
