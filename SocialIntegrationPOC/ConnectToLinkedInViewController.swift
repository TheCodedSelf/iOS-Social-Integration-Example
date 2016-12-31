//
//  ConnectToLinkedInWebView.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/30.
//  Copyright © 2016 The Coded Self. All rights reserved.
//

import Foundation
import WebKit

class ConnectToLinkedInViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    
    override func loadView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        if let webView = webView {
            webView.navigationDelegate = self
            view = webView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = webView?.load(LinkedInConnector.sharedInstance.authCodeRequest())
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("webView:\(webView) decidePolicyForNavigationAction:\(navigationAction) decisionHandler:\(decisionHandler)")
        
        let actionIsLinkActivated = navigationAction.navigationType == .linkActivated
        let actionHasTargetFrame = navigationAction.targetFrame == nil
        if  actionIsLinkActivated && actionHasTargetFrame {
            _ = webView.load(navigationAction.request)
        }
        
        decisionHandler(.allow)
        
        if let authCode = authCode(in: navigationAction.request.url) {
            requestAccessToken(authCode)
        }
    }
    
    private func authCode(in url: URL?) -> String? {
        guard let url = url,
            url.host == "com.thecodedself.socialintegrationpoc" else { return nil }
        
        let parts = url.absoluteString.components(separatedBy: "code=")
        guard parts.count > 1 else { return nil }
        
        
        let codeAndOtherParameters = parts[1]
        let code = codeAndOtherParameters.components(separatedBy: "&")[0]
        return code
    }
    
    private func requestAccessToken(_ authCode: String) {
        LinkedInConnector.sharedInstance.requestAccessToken(authCode: authCode) { (accessToken) in
            if let accessToken = accessToken {
                LinkedInConnector.sharedInstance.setAccessToken(accessToken)
            }
            DispatchQueue.main.async { [weak self] in
                _ = self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
