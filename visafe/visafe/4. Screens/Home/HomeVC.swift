//
//  HomeVC.swift
//  visafe
//
//  Created by Cuong Nguyen on 6/22/21.
//

import UIKit
import NetworkExtension

class HomeVC: BaseDoHVC {

    @IBOutlet weak var homeLoadingImage: UIImageView!
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var earthImageView: UIImageView!
    @IBOutlet weak var connectButton: UIButton!

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var desImageView: UIImageView!

    var providerManagerType: NETunnelProviderManager.Type = NETunnelProviderManager.self
    private var vpnInstalledValue: Bool?
    var manager: NETunnelProviderManager!
    var session: NETunnelProviderSession!
    let gradient = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateDNSStatus()
//        initVpn()
        NotificationCenter.default.addObserver(self, selector: #selector(updateDNSStatus),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI),
                                               name: NSNotification.Name(rawValue: updateDnsStatus),
                                               object: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gradient.frame = view.bounds
        connectionView.layer.cornerRadius = connectionView.bounds.width/2
    }

    @objc func updateDNSStatus() {
        DoHNative.shared.getDnsManagerStatus()
    }

    func setupUI() {
        connectionView.clipsToBounds = true
        gradient.frame = UIScreen.main.bounds
        gradient.colors = [UIColor.color_0F1733.cgColor, UIColor.color_102366.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

    @objc func updateUI() {
        let isEnabled = DoHNative.shared.isEnabled
        firstLabel.text = isEnabled ? "": "Bấm "
        lastLabel.text = isEnabled ? "Đang được bảo vệ": " để bật tính năng bảo vệ"
        desImageView.image = isEnabled ? UIImage(named: "Shield_Done"): UIImage(named: "power")
        earthImageView.image = isEnabled ? UIImage(named: "connection_success"): UIImage(named: "no_connection")
        connectButton.setImage(isEnabled ? UIImage(named: "connect_on"): UIImage(named: "connect_off"), for: .normal)
        homeLoadingImage.image = isEnabled ? UIImage(named: "ic_power_on"): UIImage(named: "ic_loading_home")
    }

    @IBAction func connectAction(_ sender: Any) {
        onOffDoH()
    }

    override func showAnimationLoading() {
        self.homeLoadingImage.rotate()
        self.homeLoadingImage.image = UIImage(named: "ic_loading_home")
        UIView.animate(withDuration: 0.75) {
            self.homeLoadingImage.alpha = 1
        } completion: { (success) in
        }
    }

    override func hideAnimationLoading() {
        self.homeLoadingImage.endRotate()
        UIView.animate(withDuration: 0.75) {
            self.homeLoadingImage.alpha = 0
        } completion: { (success) in
        }
    }

    override func stoprotate() {
        hideAnimationLoading()
        UIView.animate(withDuration: 0.75) {
            self.homeLoadingImage.alpha = 1
        } completion: { (success) in
        }
    }
}

//MARK: - DOH
extension HomeVC {

}

//MARK: - VPN

extension HomeVC {
    private func loadManager(_  complete:@escaping ((NETunnelProviderManager?, Error?) -> Void)) {
//        //////DDLogInfo("(VpnManager) loadManager ")
        providerManagerType.self.loadAllFromPreferences { [weak self] (managers, error) in
            guard let self = self else { return }
            var manager: NETunnelProviderManager?
            var resultError: Error?
            if error != nil {
                resultError = error
//                ////DDLogError("(VpnManager) loadManager error: \(error!)")
                complete(nil, nil)
                return
            }

            if managers?.count ?? 0 == 0 {
//                //////DDLogInfo("(VpnManager) loadManager - manager not installed")
                complete(nil, nil)
                return
            }

            if managers!.count > 1 {
//                ////DDLogError("(VpnManager) loadManager error - there are \(managers!.count) managers installed. Delete all managers")

                for manager in managers! {
                    _ = self.removeManager(manager)
                }

                manager = self.createManager()
                complete(manager, nil)
                return
            }

//            //////DDLogInfo("(VpnManager) loadManager success)")
            manager = managers?.first
            complete(manager, nil)
        }
    }

    private func removeManager(_ manager: NETunnelProviderManager)->Error? {
//        //////DDLogInfo("(VpnManager) - removeManager called")

        var resultError: Error?
        let group = DispatchGroup()
        group.enter()

        manager.removeFromPreferences { (error) in
            resultError = error
            group.leave()
        }

        group.wait()

        return resultError
    }

    private func createManager()->NETunnelProviderManager {

//        //////DDLogInfo("(VpnManager) createManager")

        let manager = providerManagerType.self.init()

        return manager
    }

    private func setupConfiguration(_ manager: NETunnelProviderManager) {
//        //////DDLogInfo("(VpnManager) setupConfiguration called")

        // do not update configuration for not premium users
//        if !appConfiguration.proStatus {
//            return
//        }

        // setup protocol configuration
        let protocolConfiguration = NETunnelProviderProtocol()
        protocolConfiguration.providerBundleIdentifier = "vn.visafe.tunnel"
        protocolConfiguration.serverAddress = "127.0.0.1"
        protocolConfiguration.username = "uid"

        manager.protocolConfiguration = protocolConfiguration
        manager.isEnabled = true

        let connectRule = NEOnDemandRuleConnect()
        connectRule.interfaceTypeMatch = .any
//        connectRule.dnsServerAddressMatch = ["https://dns-staging.visafe.vn/dns-query/"]
//        connectRule.dnsSearchDomainMatch = ["https://dns-staging.visafe.vn/dns-query/"]
//        let evaluationRule = NEEvaluateConnectionRule(matchDomains: ["visafe.vn"], andAction: .connectIfNeeded)
//        evaluationRule.useDNSServers = ["https://dns-staging.visafe.vn/dns-query/"]
//        let onDemandRule = NEOnDemandRuleEvaluateConnection()
//        onDemandRule.connectionRules = [evaluationRule]
//        onDemandRule.interfaceTypeMatch = NEOnDemandRuleInterfaceType.any
        manager.onDemandRules = [connectRule]

        manager.isOnDemandEnabled = true

        manager.localizedDescription = "Visafe"
    }

    private func saveManager(_ manager: NETunnelProviderManager, _ complete:@escaping ((Error?) -> Void)) {
        manager.saveToPreferences { (error) in
            complete(error)
        }
    }
}

extension HomeVC {
    func initVpn() {

        self.loadManager { (oldManager, error) in
            if oldManager != nil {
//                _ = self.removeManager(oldManager!)
                self.manager = oldManager
                self.session = (self.manager.connection as! NETunnelProviderSession)
                do {
                    try self.session.startVPNTunnel(options: nil)
                } catch let error1 {
                    print(error1.localizedDescription)
                }
                return
            }
            let ma = self.createManager()
    //
            self.setupConfiguration(ma)
    //
            self.saveManager(ma, { error in
                if error == nil {
//                    do {
//                        try self.manager.connection.startVPNTunnel()
//                    } catch let error1 {
//                        print(error1.localizedDescription)
//                    }
                    self.initVpn()
                } else {
                    print("save fail")
                }
            })
        }



//
//        self.vpnInstalledValue = error == nil
    }
}
