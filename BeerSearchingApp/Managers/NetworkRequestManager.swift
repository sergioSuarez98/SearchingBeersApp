//
//  NetworkRequestManager.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkRequest {
    
    associatedtype Model
    
    typealias HTTPHeader = [String : String]
    
    var baseURL : String { get }
    
    var endpoint : String { get }
    
    var httpHeaders : HTTPHeader { get }
    
    var params : [String : Any] { get }
    
    var httpMethod : HTTPMethods {get}
    
    init(model: Model)
    
    
}

extension NetworkRequest {
    var baseURL : String {"https://api.punkapi.com/v2/"}
    var httpMethod : HTTPMethods {.get}
    var httpHeaders:HTTPHeader {return ["Conten-Type" : "application/json", "Accept": "application/json", "Authorization" : ""]}
}
