//
//  LoginViewController.swift
//  RoomMe
//
//  Created by Baraa Hesham on 6/6/19.
//  Copyright © 2019 Baraa Hesham. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseUI
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FUIAuthDelegate  {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if error == nil{
            // user signed in
            print("login successfuly user = \(user?.uid)")
            self.performSegue(withIdentifier: "login", sender: nil)
        }else{
            //sign in failed
            showSimpleAlert(title: "Login Failed" , message: "Failed to sign in")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // user listener, will implement it after logout implementation
        
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                // User is signed in.
//                self.performSegue(withIdentifier: "login", sender: nil)
//                print("user is already login = \(user?.uid)")
//            } else {
//                // No user is signed in.
//            }
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginNow(_ sender: Any) {
        
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI!.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIFacebookAuth(),
            FUIGoogleAuth()]
        authUI!.providers = providers
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
        
    }
    private func showSimpleAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actoinOk = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actoinOk)
        present(alert, animated: true, completion: nil)
    }
}
