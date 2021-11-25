//
//  Common.swift
//  visafe
//
//  Created by Cuong Nguyen on 8/3/21.
//

import UIKit

class Common {
    
    class func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString.lowercased()
    }
    
    class func getDeviceInfo() -> AddDeviceToGroupParam {
        let param = AddDeviceToGroupParam()
        param.deviceName = UIDevice.current.name
        param.macAddress = UIDevice.current.identifierForVendor?.uuidString
        param.deviceId = CacheManager.shared.getDeviceId()
        param.ipAddress = "127.0.0.1"
        param.deviceType = UIDevice.current.model == "iPhone" ? "Mobile" : "Tablet"
        param.deviceOwner = UIDevice.current.name
        param.deviceDetail = "{\"iOSVersion\":\"30 (11)\",\"kernel\":\"4.14.190-20973144-abA715FXXU3BUB5\"}"
        return param
    }

    class func GetDomainDOH() -> String {
            let url = URL(string: "https://app.visafe.vn/api/v1/routing")
            var domain_doh:String = "dns.visafe.vn"
            guard let requestUrl = url else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "GET"
            request.timeoutInterval = 3000
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                guard let data = data else {return}
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    DispatchQueue.main.async {
                        if let httpResponse = response as? HTTPURLResponse{
                            if httpResponse.statusCode == 200{
                                domain_doh = json["hostname"] as! String
                            }
                        }
                    }
                }catch _{

                }
            }
            task.resume()
            return "https://" + domain_doh + "/dns-query/"
        }
    class func getDnsServer() -> String {
        if let _vip = CacheManager.shared.getVipDOH() {
            return _vip + CacheManager.shared.getDeviceId()
        }
        var dnsServer:String = CacheManager.shared.getDnsServer()! + CacheManager.shared.getDeviceId()
        return dnsServer
    }
}
