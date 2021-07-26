//
//  NotificationWorker.swift
//  visafe
//
//  Created by Cuong Nguyen on 7/11/21.
//

import UIKit
import Foundation
import ObjectMapper
import SwiftyJSON

class NotificationWorker {
    
    static func list(page: Int, completion: @escaping (_ result: NotificationResult?, _ error: Error?) -> Void) {
        let router = APIRouter.listNotification(pageIndex: page)
        APIManager.shared.request(target: router) { (data, error) in
            var result: NotificationResult?
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    result = Mapper<NotificationResult>().map(JSONObject: json)
                } catch { }
            }
            completion(result, error)
        }
    }
}