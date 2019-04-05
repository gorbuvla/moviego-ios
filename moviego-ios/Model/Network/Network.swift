//
//  Network.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Alamofire
import Reqres
import RxAlamofire
import RxSwift

typealias RequestURL = String

extension RequestURL {
    
    var absoluteUrl: URLConvertible {
        get { return Environment.baseUrl + self }
    }
}

class Network {
    
    private let sessionManager: SessionManager = {
        let config = Reqres.defaultSessionConfiguration()
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let alamofireManager = SessionManager(configuration: config)
        Reqres.sessionDelegate = alamofireManager.delegate
        return alamofireManager
    }()
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String:Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)> {
        return sessionManager
                .rx
                .request(method, url.absoluteUrl, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseData()
    }
}
