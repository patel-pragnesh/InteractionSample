//
//  API.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/21.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import Alamofire

class API {}

extension API {
    
    enum Router: URLRequestConvertible {
        static let baseURLString = "https://qiita.com/api/v2/"
        static var OAuthToken: String?
        
        case Item([String: AnyObject])
        
        var method: Alamofire.Method {
            switch self {
            default:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Item:
                return "/items"
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            if let token = Router.OAuthToken {
                mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            switch self {
            case .Item(let params):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
//            default:
//                return mutableURLRequest
            }
        }
        
    }
}
