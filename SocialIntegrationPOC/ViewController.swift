//
//  ViewController.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/25.
//  Copyright © 2016 Shnapped. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionStackView: UIStackView?
    
    @IBOutlet weak var connectToLinkedInButton: UIButton?

    @IBOutlet weak var viewFacebookDataButton: UIButton?
    @IBOutlet weak var viewLinkedInDataButton: UIButton?
    
    var facebookConnected: Bool {
        get {
            return FBSDKAccessToken.current() != nil
        }
    }
    let linkedInConnected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Social Integration POC"
        
        let loginButton = FacebookConnector.loginButton()
        connectionStackView?.addArrangedSubview(loginButton)
        loginButton.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setButtonsVisibility()
    }
    
    fileprivate func setButtonsVisibility() {
        connectToLinkedInButton?.isHidden = linkedInConnected
        viewFacebookDataButton?.isHidden = !facebookConnected
        viewLinkedInDataButton?.isHidden = !linkedInConnected
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectToFacebook(_ sender: Any) {
    }

    @IBAction func connectToLinkedIn(_ sender: Any) {
    }
}

extension ViewController: FBSDKLoginButtonDelegate {
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out!")
    }

    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        guard error == nil else {
            print("Error: \(error)")
            return
        }
        
        guard result.isCancelled == false else {
            print("FB login cancelled.")
            return
        }
        
        print("Successfully logged into facebook.")
        
        FBSDKAccessToken.setCurrent(result.token)
        setButtonsVisibility()
    }

    
}
