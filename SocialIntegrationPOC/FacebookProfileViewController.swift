//
//  FacebookProfileViewController.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/25.
//  Copyright © 2016 Shnapped. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FacebookProfileViewController: ViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Facebook Profile"
        
        FacebookConnector().startGraphRequestConnection(completionHandler: { (result, error) -> Void in
            let textToDisplay = error?.localizedDescription ?? result?.description
            self.textView.text = textToDisplay
        })
    }
    
}
