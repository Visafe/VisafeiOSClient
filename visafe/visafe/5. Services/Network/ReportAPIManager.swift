//
//  APIManager.swift
//  TripTracker
//
//  Created by quangpc on 7/23/18.
//  Copyright © 2018 triptracker. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import SwiftyJSON
//import SwiftyUserDefaults
class ReportAPIManager {

    static let shared = ReportAPIManager()

    let provider = MoyaProvider<ReportAPIRouter>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

    @discardableResult
    func request(target: ReportAPIRouter, completion: @escaping (_ data: Data?, _ error: Error?, _ statusCode: Int?) -> Void) -> Cancellable {
        return provider.request(target, completion: { (result) in
            switch result {
            case .success(let response):
                completion(response.data, nil, response.response?.statusCode)
            case .failure(_):
                completion(nil, APIError.serverLogicError(message: "Something's wrong with server."), nil)
            }

        })
    }
}
