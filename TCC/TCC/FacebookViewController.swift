//
//  FacebookViewController.swift
//  TCC
//
//  Created by Piera Marchesini on 13/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FacebookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.userPosts, .publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
        }
    }
    
    func getProfileInfo() {
        if let access = AccessToken.current {
            let graph = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"], accessToken: access, httpMethod: .GET, apiVersion: .defaultVersion)
            graph.start { (httpResponse, result) in
                switch result {
//                    print(result)
                case .success(response: let suc):
                    print(result)
//                    suc.stringValue
                case .failed(let error):
                    print(result)
                }
//                let id = result.id
//                GraphRequestResult<GraphRequest>.success(response: <#T##T.Response#>)
            }
        }
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
