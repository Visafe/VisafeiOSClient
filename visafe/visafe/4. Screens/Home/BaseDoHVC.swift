//
//  BaseDoHVC.swift
//  visafe
//
//  Created by Nguyễn Tuấn Vũ on 10/08/2021.
//

import Foundation
import UIKit

class BaseDoHVC: BaseViewController {
    var isConnecting: Bool = false

    func showAnimationConnectLoading() {}

    func hideAnimationLoading() {}

    func stoprotate() {
        hideAnimationLoading()
    }

    func onOffDoH() {
        let localStatus = CacheManager.shared.getDohStatus() ?? false
        DoHNative.shared.canPushNoti = true
        if DoHNative.shared.isInstalled {
            if localStatus {
                if DoHNative.shared.isEnabled {
                    if CacheManager.shared.getPin() != nil {
                        gotoEnterPin()
                    } else {
                        offDoH()
                    }
                } else {
                    offDoH()
                }
            } else {
                isConnecting = false
                if DoHNative.shared.isEnabled {
                    DoHNative.shared.onOffDoH(true, handleSaveSuccess)
                } else {
                    DoHNative.shared.onOffDoH(true, handleSaveSuccess)
                }
            }

        } else {
            DoHNative.shared.saveDNS {[weak self] (error) in
                if let _error = error {
                    self?.handleSaveError(_error)
                } else {
                    self?.handleSaveSuccess()
                }
                self?.isConnecting = false
            }
        }
    }

    func offDoH() {
        DoHNative.shared.onOffDoH(false, handleSaveSuccess)
        isConnecting = false
    }

    func gotoEnterPin() {
        let vc = EnterPinVC()
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        vc.screenType = .confirmToOffDoH
        vc.confirmPin = { [weak self] isSuccess in
            if isSuccess {
                self?.offDoH()
            } else {
                self?.isConnecting = false
            }
        }
        self.navigationController?.present(navi, animated: true, completion: nil)
    }

    func handleSaveError(_ error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //            self.stoprotate()
            self.showWarning(title: "Thông báo", content: error.localizedDescription)
        }
    }

    func handleSaveSuccess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.stoprotate()
            self.showWarning(title: "Hướng dẫn cài đặt DNS Visafe",
                             content: "Mở Cài đặt -> Cài đặt chung -> Quản lý VPN & thiết bị -> DNS -> Chọn Visafe") {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }

                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl,
                                                      completionHandler: nil)
                        }
            }
        }
    }
}
