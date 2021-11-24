//
//  ProfileVC.swift
//  visafe
//
//  Created by Cuong Nguyen on 7/8/21.
//

import UIKit
import Toast_Swift

class NotiSettingVC: BaseViewController, UNUserNotificationCenterDelegate {


    @IBOutlet weak var switch_dns_server: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(applicationWillEnterForeground),
                                                   name: UIApplication.willEnterForegroundNotification,
                                                   object: nil)
    }
    
    func configView() {
        title = "Cấu hình thông báo"
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                DispatchQueue.main.async {
                    self.switch_dns_server.setImage(UIImage(named: "Switch_off"), for: .normal)
                }
            } else if settings.authorizationStatus == .denied {
                DispatchQueue.main.async {
                    self.switch_dns_server.setImage(UIImage(named: "Switch_off"), for: .normal)
                }
            } else if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    self.switch_dns_server.setImage(UIImage(named: "Switch_on"), for: .normal)
                }
            }
        })
    }
    
    @IBAction func switch_dns_server(_ sender: UIButton) {
        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
    @objc func applicationWillEnterForeground(notification: Notification) {
        configView()
    }
}
