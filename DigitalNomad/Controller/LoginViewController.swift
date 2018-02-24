//
//  LoginViewController.swift
//  DigitalNomad
//
//  Created by Presto on 2018. 2. 24..
//  Copyright © 2018년 MokMinSimSeo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import MBProgressHUD

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil){
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
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

