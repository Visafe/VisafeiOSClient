//
//  QueryLogParam.swift
//  visafe
//
//  Created by Cuong Nguyen on 7/25/21.
//

import UIKit
import ObjectMapper

public enum QueryLogTypeEnum: String {
    case dangerous = "dangerous_domain"
    case violation = "violation"
    case ads_blocked = "ads_blocked"
    case all = "all" // truy cập
}

class QueryLogParam: NSObject, Mappable {
    var group_id: String?
    var workspace_id: String?
    var response_status: QueryLogTypeEnum?
    var older_than: Int?
    var limit: Int?
    
    override init() {
        super.init()
    }

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        group_id <- map["group_id"]
        workspace_id <- map["workspace_id"]
        response_status <- map["response_status"]
        older_than <- map["older_than"]
        limit <- map["limit"]
    }
}