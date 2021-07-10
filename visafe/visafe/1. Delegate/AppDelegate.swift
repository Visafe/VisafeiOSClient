//
//  AppDelegate.swift
//  visafe
//
//  Created by Nguyễn Tuấn Vũ on 22/06/2021.
//

import UIKit
import SideMenuSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        configRootVC()
        configView()
        configureSideMenu()
        return true
    }
    
    func configView() {
        UITabBar.appearance().tintColor = UIColor.mainColorOrange()
        UIBarButtonItem.appearance().tintColor = UIColor.black
    }
    
    func configRootVC() {
        if CacheManager.shared.getIsShowOnboarding() {
            setRootVCToTabVC()
        } else {
            setRootVCToOnboardingVC()
        }
    }
    
    func setRootVCToTabVC() {
        let vc = TabbarVC()
        setRootViewController(vc)
    }
    
    func setRootVCToOnboardingVC() {
        let vc = OnboardingVC()
        setRootViewController(vc)
    }
    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = kScreenWidth - 60
        SideMenuController.preferences.basic.defaultCacheKey = "0"
    }
}

extension AppDelegate {
    class func appDelegate() -> AppDelegate? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate
    }
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
