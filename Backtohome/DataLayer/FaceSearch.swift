//
//  FaceDetect.swift
//  Backtohome
//
//  Created by chayarak on 11/12/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import Foundation
import ObjectMapper

class FaceSearch: Mappable {
    
    var results: [Results]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class Results: Mappable {
    
    var confidence: Float?
    var user_id: String?
    var face_token: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        confidence <- map["confidence"]
        user_id <- map["user_id"]
        face_token <- map["face_token"]
    }
}
