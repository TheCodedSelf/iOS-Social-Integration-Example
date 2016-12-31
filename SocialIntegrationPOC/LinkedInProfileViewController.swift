//
//  LinkedInProfileViewController.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/31.
//  Copyright © 2016 Shnapped. All rights reserved.
//

import UIKit

class LinkedInProfileViewController: UIViewController {
    @IBOutlet weak var profileUrlLabel: UILabel!
    
    override func viewDidLoad() {
        LinkedInConnector.sharedInstance.getProfileUrlString { (profileUrl) in
            DispatchQueue.main.async { [weak self] in
                self?.profileUrlLabel.text = profileUrl
            }
        }
    }
    
}
