//
//  ProfileRequest.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 17/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import FacebookCore

struct ProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}
