//
//  PostResponse.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 25/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import Foundation

struct PostResponse: Decodable {
    var data: [DataResponse]
    var paging: Paging
}

struct DataResponse: Decodable {
    var message: String?
    var id: String
}

struct Paging: Decodable {
    var previous: String
    var next: String
}
