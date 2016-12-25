//
//  ViewController.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/25.
//  Copyright © 2016 Shnapped. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var connectToFacebookButton: UIButton!
    @IBOutlet weak var connectToLinkedInButton: UIButton!

    @IBOutlet weak var viewFacebookDataButton: UIButton!
    @IBOutlet weak var viewLinkedInDataButton: UIButton!
    
    let facebookConnected = false
    let linkedInConnected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Social Integration POC"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        connectToFacebookButton.isHidden = facebookConnected
        connectToLinkedInButton.isHidden = linkedInConnected
        viewFacebookDataButton.isHidden = !facebookConnected
        viewLinkedInDataButton.isHidden = !linkedInConnected
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

