//
//  GroupModel.swift
//  visafe
//
//  Created by Cuong Nguyen on 6/28/21.
//

import UIKit
import ObjectMapper

public enum GroupTypeEnum: String {
    case adult = "adult"
    case elderly = "elderly"
    case children = "children"
    
    func getDescription() -> String {
        switch self {
        case .adult:
            return "Người lớn"
        case .children:
            return "Trẻ em"
        case .elderly:
            return "Người cao tuổi"
        }
    }
    
    static func getAll() -> [GroupTypeEnum] {
        return [.children, .adult, .elderly]
    }
}

public enum GroupAppAdsEnum: String {
    case instagram = "instagram"
    case youtube = "youtube"
    case spotify = "spotify"
    case facebook = "facebook"
    
    func getTitle() -> String {
        switch self {
        case .instagram:
            return "Instagram"
        case .youtube:
            return "Youtube"
        case .spotify:
            return "Spotify"
        case .facebook:
            return "Facebook"
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .instagram:
            return UIImage(named: "insta_icon")
        case .youtube:
            return UIImage(named: "youtube_icon")
        case .spotify:
            return UIImage(named: "spotify_icon")
        case .facebook:
            return UIImage(named: "facebook_icon")
        }
    }
    
    static func getAll() -> [GroupAppAdsEnum] {
        return [.facebook, .youtube, .instagram, .spotify, ]
    }
}

public enum BlockServcieEnum: String {
    case facebook = "facebook"
    case zalo = "zalo"
    case tiktok = "tiktok"
    case instagram = "instagram"
    case tinder = "tinder"
    case twitter = "twitter"
    case netflix = "netflix"
    case reddit = "reddit"
    case _9gag = "9gag"
    
    static func getAll() -> [BlockServcieEnum] {
        return [.facebook, .zalo, .tiktok, .instagram, .tinder, .twitter, .netflix, .reddit, ._9gag]
    }
    
    func getTitle() -> String {
        switch self {
        case .facebook:
            return "Facebook"
        case .zalo:
            return "Zalo"
        case .tiktok:
            return "Tiktok"
        case .instagram:
            return "Instagram"
        case .tinder:
            return "Tinder"
        case .twitter:
            return "Twitter"
        case .netflix:
            return "Netflix"
        case .reddit:
            return "Reddit"
        case ._9gag:
            return "9GAG"
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .facebook:
            return UIImage(named: "facebook_icon_group")
        case .zalo:
            return UIImage(named: "")
        case .tiktok:
            return UIImage(named: "")
        case .instagram:
            return UIImage(named: "insta_icon")
        case .tinder:
            return UIImage(named: "")
        case .twitter:
            return UIImage(named: "")
        case .netflix:
            return UIImage(named: "")
        case .reddit:
            return UIImage(named: "")
        case ._9gag:
            return UIImage(named: "")
        }
    }
}

public enum NativeTrackingEnum : String {
    case alexa = "alexa"
    case apple = "apple"
    case huawei = "huawei"
    case roku = "roku"
    case samsung = "samsung"
    case sonos = "sonos"
    case windows = "windows"
    case xiaomi = "xiaomi"
    
    static func getAll() -> [NativeTrackingEnum] {
        return [.apple,.samsung, .windows, .alexa, .huawei, .roku, .sonos, .xiaomi]
    }
    
    func getTitle() -> String {
        switch self {
        case .alexa:
            return "Alexa"
        case .apple:
            return "Apple"
        case .huawei:
            return "Huawei"
        case .roku:
            return "Roku"
        case .samsung:
            return "Samsung"
        case .sonos:
            return "Sonos"
        case .windows:
            return "Windows"
        case .xiaomi:
            return "Xiaomi"
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .alexa:
            return UIImage(named: "")
        case .apple:
            return UIImage(named: "apple_icon_group")
        case .huawei:
            return UIImage(named: "huawei_icon")
        case .roku:
            return UIImage(named: "")
        case .samsung:
            return UIImage(named: "samsung_icon")
        case .sonos:
            return UIImage(named: "")
        case .windows:
            return UIImage(named: "")
        case .xiaomi:
            return UIImage(named: "xiaomi_icon")
        }
    }
}


public enum SafesearchEnum: Int {
    case safesearch = 1
    case youtuberestrict = 2
    
    func getTitle() -> String {
        switch self {
        case .safesearch:
            return "Google tìm kiếm"
        case .youtuberestrict:
            return "Youtube"
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .safesearch:
            return UIImage(named: "google_icon_group")
        case .youtuberestrict:
            return UIImage(named: "youtube_icon")
        }
    }
    
    static func getAll() -> [SafesearchEnum] {
        return [.safesearch, .youtuberestrict]
    }
}

public enum PostGroupEnum: Int {
    case adblock = 1
    case gameads = 2
    case appads = 3
    case nativetracking = 4
    case service = 5
    case website = 6
    case safesearch = 7
    case gamble = 8
    case phishing = 9
    
    func getTitle() -> String {
        switch self {
        case .adblock:
            return "Chặn quảng cáo Website"
        case .gameads:
            return "Chặn quảng cáo Game"
        case .appads:
            return "Chặn quảng cáo ứng dụng"
        case .nativetracking:
            return "Chặn theo dõi trên thiết bị"
        case .service:
            return "Ứng dụng"
        case .website:
            return "Websites"
        case .safesearch:
            return "Chặn nội dung người lớn"
        case .gamble:
            return "Chặn nội dung cờ bạc"
        case .phishing:
            return "Chặn tin tức giả"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .adblock:
            return "Chặn các quảng cáo hiển thị trên các website"
        case .gameads:
            return "Chặn các quảng cáo hiển thị trên các game, ứng dụng trên di động"
        case .appads:
            return "Chặn các quảng cáo đặc thù của một số ứng dụng phổ biến"
        case .nativetracking:
            return "Chặn theo dõi, thu thập dữ liệu thông tin cá nhân trên các thiết bị, hệ điều hành"
        case .service:
            return "Chặn truy cập đến các ứng dụng có trong danh sách"
        case .website:
            return "Chặn truy cập đến các website trong danh sách"
        case .safesearch:
            return "Ngăn chặn các nội dung không phù hợp, nhạy cảm, bình luận,..."
        case .gamble:
            return "Ngăn chặn các nội dung liên quan đến cờ bạc, cá độ"
        case .phishing:
            return "Ngăn chặn các tin tức giả, không chính thống"
        }
    }
    
    static func getAll() -> [PostGroupEnum] {
        return [.adblock, .gameads, .appads, .nativetracking, .service, .website, .safesearch, .gamble, .phishing]
    }
}



public class BaseGroupModel: NSObject {
    var isSelected: Bool?
}

public class AppAdsModel: BaseGroupModel {
    var type: GroupAppAdsEnum?
}

public class NativeTrackingModel: BaseGroupModel {
    var type: NativeTrackingEnum?
}

public class BlockServiceModel: BaseGroupModel {
    var type: BlockServcieEnum?
}

public class SafeSearchModel: BaseGroupModel {
    var type: SafesearchEnum?
}

public class PostGroupModel: BaseGroupModel {
    var type: PostGroupEnum?
    var children: [Any] = []
}


class GroupModel: NSObject, Mappable {
    var groupid: String?
    var adblock_enabled: Bool?
    var app_ads: [String] = []
    var block_webs: [String] = []
    var blocked_services: [String] = []
    var bypass_enabled: Bool?
    var gambling_enabled: Bool?
    var game_ads_enabled: Bool?
    var malware_enabled: Bool?
    var name: String?
    var native_tracking: [String] = []
    var object_type: [GroupTypeEnum] = []
    var parental_enabled: Bool?
    var phishing_enabled: Bool?
    var porn_enabled: Bool?
    var safesearch_enabled: Bool?
    var youtuberestrict_enabled: Bool?
    var workspace_id: String?
    var isOwner: Bool?
    var fkUserId: Int?
    var ids: [String]?
    var tags: [String]?
    var use_global_settings: Bool?
    var use_global_blocked_services: Bool?
    var upstreams: [String]?
    var disallowed: Bool?
    var usersActive: [UserModel]?
    var userManage: [UserModel]?
    var usersGroupInfo: [UserModel]?
    var days: [String] = []
    var times: [String] = []
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        adblock_enabled <- map["adblock_enabled"]
        app_ads <- map["app_ads"]
        block_webs <- map["block_webs"]
        blocked_services <- map["blocked_services"]
        bypass_enabled <- map["bypass_enabled"]
        gambling_enabled <- map["gambling_enabled"]
        game_ads_enabled <- map["game_ads_enabled"]
        malware_enabled <- map["malware_enabled"]
        name <- map["name"]
        native_tracking <- map["native_tracking"]
        object_type <- map["object_type"]
        parental_enabled <- map["parental_enabled"]
        phishing_enabled <- map["phishing_enabled"]
        porn_enabled <- map["porn_enabled"]
        safesearch_enabled <- map["safesearch_enabled"]
        youtuberestrict_enabled <- map["youtuberestrict_enabled"]
        workspace_id <- map["workspace_id"]
        isOwner <- map["isOwner"]
        groupid <- map["groupid"]
        fkUserId <- map["fkUserId"]
        ids <- map["ids"]
        tags <- map["tags"]
        use_global_settings <- map["use_global_settings"]
        use_global_blocked_services <- map["use_global_blocked_services"]
        upstreams <- map["upstreams"]
        disallowed <- map["disallowed"]
        usersActive <- map["usersActive"]
        userManage <- map["userManage"]
        usersGroupInfo <- map["usersGroupInfo"]
        days <- map["days"]
        times <- map["times"]
    }
    
    func buildModelsAppAds(value: [String]) -> [AppAdsModel] {
        var responses: [AppAdsModel] = []
        for type in GroupAppAdsEnum.getAll() {
            let model = AppAdsModel()
            model.type = type
            model.isSelected = value.contains(type.rawValue)
            responses.append(model)
        }
        return responses
    }
    
    func buildTracking(value: [String]) -> [NativeTrackingModel] {
        var responses: [NativeTrackingModel] = []
        for type in NativeTrackingEnum.getAll() {
            let model = NativeTrackingModel()
            model.type = type
            model.isSelected = value.contains(type.rawValue)
            responses.append(model)
        }
        return responses
    }
    
    func buildModelsBlockService(value: [String]) -> [BlockServiceModel] {
        var responses: [BlockServiceModel] = []
        for type in BlockServcieEnum.getAll() {
            let model = BlockServiceModel()
            model.type = type
            model.isSelected = value.contains(type.rawValue)
            responses.append(model)
        }
        return responses
    }
    
    func buildModelsSafeSearch() -> [SafeSearchModel] {
        var responses: [SafeSearchModel] = []
        let model = SafeSearchModel()
        model.type = .safesearch
        model.isSelected = safesearch_enabled
        responses.append(model)
        let model2 = SafeSearchModel()
        model2.type = .youtuberestrict
        model2.isSelected = youtuberestrict_enabled
        responses.append(model2)
        return responses
    }
    
    func buildSource(type: GroupSettingParentEnum) -> [PostGroupModel] {
        if type == .blockAds {
            var sources = [PostGroupModel]()
            // Chặn quảng cáo Website
            let m1 = PostGroupModel()
            m1.isSelected = adblock_enabled
            m1.type = .adblock
            sources.append(m1)
            // Chặn quảng cáo game, ứng dụng
            let m2 = PostGroupModel()
            m2.isSelected = game_ads_enabled
            m2.type = .gameads
            sources.append(m2)
            // Chặn quảng cáo nâng cao
            let m3 = PostGroupModel()
            m3.isSelected = true
            m3.type = .appads
            m3.children = buildModelsAppAds(value: app_ads)
            sources.append(m3)
            return sources
        } else if type == .blockConnect {
            var sources = [PostGroupModel]()
            // Ứng dụng
            let m5 = PostGroupModel()
            m5.type = .service
            m5.isSelected = true
            m5.children = buildModelsBlockService(value: blocked_services)
            sources.append(m5)
            // Website
            let m6 = PostGroupModel()
            m6.type = .website
            m6.isSelected = true
            m6.children = block_webs
            sources.append(m6)
            return sources
        } else if type == .blockContent {
            var sources = [PostGroupModel]()
            // Giới hạn nội dung tìm kiếm
            let m7 = PostGroupModel()
            m7.type = .safesearch
            m7.isSelected = safesearch_enabled ?? youtuberestrict_enabled ?? false
            m7.children = buildModelsSafeSearch()
            sources.append(m7)
            // Chặn nội dung cờ bạc
            let m8 = PostGroupModel()
            m8.isSelected = gambling_enabled
            m8.type = .gamble
            sources.append(m8)
            // Chặn tin tức giả
            let m9 = PostGroupModel()
            m9.isSelected = phishing_enabled
            m9.type = .phishing
            sources.append(m9)
            return sources
        } else if type == .blockFollow {
            var sources = [PostGroupModel]()
            // Chặn theo dõi thiết bị
            let m4 = PostGroupModel()
            m4.type = .nativetracking
            m4.isSelected = true
            m4.children = buildTracking(value: native_tracking)
            sources.append(m4)
            return sources
        } else {
            return []
        }
    }
    
    func bindingData(sources: [PostGroupModel]) {
        for model in sources {
            guard let type = model.type else { break }
            switch type {
            case .adblock:
                adblock_enabled = model.isSelected
            case .gameads:
                game_ads_enabled = model.isSelected
            case .appads:
                if model.isSelected ?? false {
                    var res: [String] = []
                    for item in model.children as? [AppAdsModel] ?? [] {
                        if item.isSelected == true {
                            if let type = item.type {
                                res.append(type.rawValue)
                            }
                        }
                    }
                    app_ads = res
                } else {
                    app_ads = []
                }
            case .website:
                if model.isSelected ?? false {
                    block_webs = model.children as? [String] ?? []
                } else {
                    block_webs = []
                }
            case .nativetracking:
                if model.isSelected ?? false {
                    var res: [String] = []
                    for item in model.children as? [NativeTrackingModel] ?? [] {
                        if item.isSelected == true {
                            if let type = item.type {
                                res.append(type.rawValue)
                            }
                        }
                    }
                    native_tracking = res
                } else {
                    native_tracking = []
                }
            case .service:
                if model.isSelected ?? false {
                    var res: [String] = []
                    for item in model.children as? [BlockServiceModel] ?? [] {
                        if item.isSelected == true {
                            if let type = item.type {
                                res.append(type.rawValue)
                            }
                        }
                    }
                    blocked_services = res
                } else {
                    blocked_services = []
                }
            case .safesearch:
                if model.isSelected ?? false {
                    let models = model.children as? [SafeSearchModel] ?? []
                    for item in models {
                        if let type = item.type {
                            switch type {
                            case .safesearch:
                                safesearch_enabled = item.isSelected
                            case .youtuberestrict:
                                youtuberestrict_enabled = item.isSelected
                            }
                        }
                    }
                } else {
                    safesearch_enabled = false
                    youtuberestrict_enabled = false
                }
            case .gamble:
                gambling_enabled = model.isSelected
            case .phishing:
                phishing_enabled = model.isSelected
            }
        }
    }
    
    static func getDefaultModel() -> GroupModel {
        let model = GroupModel()
        model.adblock_enabled = true
        model.game_ads_enabled = true
        model.app_ads = [GroupAppAdsEnum.facebook.rawValue, GroupAppAdsEnum.youtube.rawValue]
        model.native_tracking = [NativeTrackingEnum.apple.rawValue, NativeTrackingEnum.samsung.rawValue]
        model.blocked_services = [BlockServcieEnum.facebook.rawValue, BlockServcieEnum.zalo.rawValue, BlockServcieEnum.instagram.rawValue, BlockServcieEnum.tiktok.rawValue]
        
        model.bypass_enabled = true
        model.safesearch_enabled = true
        return model
    }
    
    func setDefault(type: GroupSettingParentEnum) {
        if type == .blockAds {
            adblock_enabled = true
            game_ads_enabled = true
            app_ads = [GroupAppAdsEnum.facebook.rawValue, GroupAppAdsEnum.youtube.rawValue]
        } else if type == .blockConnect { // truy cập
            blocked_services = [BlockServcieEnum.facebook.rawValue, BlockServcieEnum.zalo.rawValue, BlockServcieEnum.instagram.rawValue, BlockServcieEnum.tiktok.rawValue]
            block_webs = []
        } else if type == .blockContent {
            safesearch_enabled = true
            youtuberestrict_enabled = false
            gambling_enabled = false
            phishing_enabled = false
        } else if type == .blockFollow {
            native_tracking = [NativeTrackingEnum.apple.rawValue, NativeTrackingEnum.samsung.rawValue]
        } else {
            bypass_enabled = true
        }
    }
    
    func getState(type: GroupSettingParentEnum) -> Bool {
        if type == .blockAds {
            return (adblock_enabled == true ||
                game_ads_enabled == true ||
                app_ads.count > 0)
        } else if type == .blockConnect { // truy cập
            return (app_ads.count > 0)
        } else if type == .blockContent {
            return (safesearch_enabled == true)
        } else if type == .blockFollow {
            return (native_tracking.count > 0)
        } else {
            return (bypass_enabled == true)
        }
    }
    
    func disable(type: GroupSettingParentEnum) {
        if type == .blockAds {
            adblock_enabled = false
            game_ads_enabled = false
            app_ads = []
        } else if type == .blockConnect { // truy cập
            blocked_services = []
        } else if type == .blockContent {
            safesearch_enabled = false
            youtuberestrict_enabled = false
            gambling_enabled = false
            phishing_enabled = false
        } else if type == .blockFollow {
            native_tracking = []
        } else {
            bypass_enabled = false
        }
    }
    
    func getAllModel() -> [PostGroupParentModel] {
        var sources: [PostGroupParentModel] = []
        let enums: [GroupSettingParentEnum] = [.blockAds, .blockFollow, .blockConnect, .blockContent, .blockVPN]
        for item in enums {
            let model = PostGroupParentModel()
            model.type = item
            model.isSelected = getState(type: item)
            sources.append(model)
        }
        return sources
    }
}
