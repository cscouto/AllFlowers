//
//  BaseAPI.swift
//  AllFlowers
//
//  Created by Tiago Do Couto on 11/09/17.
//  Copyright © 2017 Tiago Do Couto. All rights reserved.
//

import UIKit
import Alamofire

public struct BaseAPI {
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    var flowerName: String!
    var indexpageids: String!
    
   static func request(flowerName: String){
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            ]
    Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                
            }
        }
    }
}
