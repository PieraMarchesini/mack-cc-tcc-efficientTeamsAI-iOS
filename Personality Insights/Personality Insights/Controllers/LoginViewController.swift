//
//  ViewController.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 16/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit
import FacebookLogin

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var managerView: UIView!
    @IBOutlet weak var memberView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setup(view: UIView) {
        if view.tag == 1 {
            view.backgroundColor = UIColor(red: 235/255, green: 213/255, blue: 103/255, alpha: 1)
        } else {
            view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        }
    }
    
    func enableConfirm() {
        if managerView.tag == 1 || memberView.tag == 1 {
            self.confirmButton.isEnabled = true
            self.confirmButton.backgroundColor = UIColor(red: 119/255, green: 86/255, blue: 236/255, alpha: 1)
            self.confirmButton.setTitleColor(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1), for: .normal)
        } else {
            self.confirmButton.isEnabled = false
            self.confirmButton.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
            self.confirmButton.setTitleColor(UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1), for: .normal)
        }
    }
    
    func enableFacebook() {
        self.fbButton.isHidden = self.memberView.tag == 1 ? false : true
        self.confirmButton.isHidden = self.fbButton.isHidden ? false : true
    }

    //MARK: - Actions
    @IBAction func managerButtonPressed(_ sender: UIButton) {
        self.managerView.tag = self.managerView.tag == 1 ? 0 : 1
        self.memberView.tag = self.managerView.tag == 1 ? 0 : self.memberView.tag
        enableConfirm()
        enableFacebook()
        setup(view: managerView)
        setup(view: memberView)
    }
    
    @IBAction func memberButtonPressed(_ sender: UIButton) {
        self.memberView.tag = self.memberView.tag == 1 ? 0 : 1
        self.managerView.tag = self.memberView.tag == 1 ? 0 : self.managerView.tag
        enableConfirm()
        enableFacebook()
        setup(view: memberView)
        setup(view: managerView)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        if self.managerView.tag == 1 {
            self.performSegue(withIdentifier: "toManager", sender: nil)
        }
    }
    
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.userPosts, .publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions):
                //let grantedPermissions, let declinedPermissions, let accessToken
                print("Logged in! \(grantedPermissions)")
                let storyboard = UIStoryboard(name: "Member", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "member") as? MemberViewController {
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
//        self.performSegue(withIdentifier: "toMember", sender: nil)
    }
}

