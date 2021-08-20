//
//  ScanVC.swift
//  visafe
//
//  Created by Cuong Nguyen on 7/27/21.
//

import UIKit
import ObjectMapper

public enum ScanDescriptionEnum: String {
    case about = "KIỂM TRA BẢO MẬT"
    case protect = "CHẾ ĐỘ BẢO VỆ"
    case wifi = "BẢO VỆ WI-FI"
    case protocoll = "PHƯƠNG THỨC BẢO VỆ"
    case system = "HỆ ĐIỀU HÀNH"
    
    func getDescription() -> String {
        switch self {
        case .about:
            return "ViSafe giúp bạn kiểm tra toàn diện về nguy hại, mã độc, quảng cáo & theo dõi."
        case .protect:
            return "Đang bật chế độ bảo vệ ViSafe"
        case .wifi:
            return "Đang kiểm tra wifi"
        case .protocoll:
            return "Đang thiết lập các phương thức bảo vệ"
        case .system:
            return "Đang kiểm tra phiên bản hệ điều hành"
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .about:
            return UIImage(named: "ic_scan_visafe")
        case .protect:
            return UIImage(named: "ic_scan_device")
        case .wifi:
            return UIImage(named: "ic_scan_wifi")
        case .protocoll:
            return UIImage(named: "ic_scan_ads")
        case .system:
            return UIImage(named: "ic_scan_tracking")
        }
    }
    
    static func getAll() -> [ScanDescriptionEnum] {
        return [.about, .protect, .wifi, .protocoll, .system]
    }
}

class ScanVC: BaseViewController {
    
    var type: ScanDescriptionEnum = .about
    
    @IBOutlet weak var contraintHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    init(type: ScanDescriptionEnum) {
        self.type = type
        super.init(nibName: ScanVC.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        descriptionImage.image = type.getIcon()
        titleLabel.text = type.rawValue
        descriptionLabel.text = type.getDescription()
        view.backgroundColor = UIColor.clear
        contraintHeight.constant = kScreenHeight/2
    }
}