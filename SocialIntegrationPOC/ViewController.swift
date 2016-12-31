//
//  ViewController.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/25.
//  Copyright © 2016 The Coded Self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionStackView: UIStackView?
    
    @IBOutlet weak var connectToLinkedInButton: UIButton?

    @IBOutlet weak var viewFacebookDataButton: UIButton?
    @IBOutlet weak var viewLinkedInDataButton: UIButton?
    
    var facebookConnector = FacebookConnector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Social Integration POC"
        
        let loginButton = facebookConnector.loginButton(completedCallback: facebookConnected, loggedOutCallback: {
            print("Logged out!")
        })
        
        connectionStackView?.addArrangedSubview(loginButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setButtonsVisibility()
    }
    
    private func facebookConnected(isCancelled: Bool, error: Error?) {
        guard error == nil else {
            print("Error: \(error)")
            return
        }
        
        guard isCancelled == false else {
            print("FB login cancelled.")
            return
        }
        
        print("Successfully logged into facebook.")
        
        self.setButtonsVisibility()
    }
    
    private func setButtonsVisibility() {
        connectToLinkedInButton?.isHidden = LinkedInConnector.sharedInstance.connected
        viewFacebookDataButton?.isHidden = !FacebookConnector.isConnected()
        viewLinkedInDataButton?.isHidden = !LinkedInConnector.sharedInstance.connected
    }
}
