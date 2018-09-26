//
//  MemberViewController.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 17/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit
import FacebookCore

class MemberViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var messages = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.setRounded()
        connectFB()
        getPosts()
    }
    
    func connectFB() {
        GraphRequest(graphPath: "me", parameters: ["fields":"first_name,picture.width(480).height(480)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion).start { (connection, result) in
            //            "id,interested_in,gender,birthday,email,age_range,name,picture.width(480).height(480)"
            switch result {
            case .success(response: let res):
                let r = res as GraphResponse
                if let dic = r.dictionaryValue {
                    let name = dic["first_name"] as! String
                    DispatchQueue.main.async {
                        self.nameLabel.text = "Olá, \(name)"
                    }
                    if let a = dic["picture"] as? [String: Any], let b = a["data"] as? [String : Any] {
                        if let str = b["url"] as? String,
                            let url = URL(string: str),
                            let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.profileImage.image = UIImage(data: data)
                            }
                        }
                    }
                }
                print(result)
            case .failed(let err):
                print(err)
            }
        }
    }
    
    func getPosts() {
        getFirstPosts { (messages, url) in
            self.messages.append(messages)
            if let url = url {
                self.getPostsToAppend(link: url, completion: { (message, nextLink) in
                    self.messages.append(message)
                    if let url = nextLink {
                        self.getPostsToAppend(link: url, completion: { (message, nextLink) in
                            self.messages.append(message)
                            if let url = nextLink, self.messages.count < 8000 {
                                self.getPostsToAppend(link: url, completion: { (message, nextLink) in
                                    self.messages.append(message)
                                    if let url = nextLink, self.messages.count < 8000 {
                                        self.getPostsToAppend(link: url, completion: { (message, nextLink) in
                                            self.messages.append(message)
                                            self.messages = self.messages.stringByRemovingEmoji()
                                            self.messages = self.messages.stringByRemovingHashtag()
                                            if let url = nextLink, self.messages.count < 8000 {
                                                self.getPostsToAppend(link: url, completion: { (message, nextLink) in
                                                    self.messages.append(message)
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }
    }
    
    func getFirstPosts(completion: @escaping (String, String?) -> Void) {
        GraphRequest(graphPath: "me/posts", parameters: [:], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion).start { (connection, result) in
            switch result {
            case .success(response: let res):
                let r = res as GraphResponse
                if let dic = r.dictionaryValue {
                    var nextLink = ""
                    var mess = ""
                    if let a = dic["paging"] as? [String : Any],
                    let link = a["next"] as? String {
                        nextLink = link
                    }
                    if let b = dic["data"] as? [[String : Any]] {
                        for elem in b {
                            for j in elem {
                                let d = j as (key: String, value: Any)
                                if d.key == "message",
                                    let e = d.value as? String {
                                    mess.append(e)
                                }
                            }
                        }
                    }
                    
                    completion(mess, nextLink)
                }
            case .failed(let err):
                print(err)
                
            }
            print(result)
        }
    }
    
    func getPostsToAppend(link: String, completion: @escaping (String, String?) -> Void) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { (responseData, responseUrl, err) in
            if let data = responseData {
                do {
                    var mess = ""
                    let result = try JSONDecoder().decode(PostResponse.self, from: data)
                    for datinha in result.data {
                        if let message = datinha.message {
                            mess.append(" ")
                            mess.append(message)
                        }
                    }
                    let link = result.paging.next
                    completion(mess, link)
                } catch {
                    print("deu ruim")
                    completion("", nil)
                }
                
            }
            }.resume()
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
