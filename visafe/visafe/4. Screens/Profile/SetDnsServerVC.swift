//
//  SetDnsServerVC.swift
//  visafe
//
//  Created by NCSC P5 on 11/24/21.
//

import Foundation
import UIKit

class SetDnsServerVC:BaseDoHVC{
    @IBOutlet weak var radio0: UIButton!
    @IBOutlet weak var radio1: UIButton!
    @IBOutlet weak var radio2: UIButton!
    @IBOutlet weak var radio3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    @objc func onClickLeftButton() {
        dismiss(animated: true)
    }
    func initView()
    {
        title = "Cấu hình bảo vệ"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "navi_back"), style: .done, target: self, action: #selector(onClickLeftButton))
        navigationItem.leftBarButtonItem = leftBarButton
        var currentdoh = CacheManager.shared.getDnsServer()
        if currentdoh == "https://security.visafe.vn/dns-query/"
        {
            UpdateRadioStatus(num: 0)
        }
        else if currentdoh == "https://family.visafe.vn/dns-query/"
        {
            UpdateRadioStatus(num: 1)
        }
        else if currentdoh == "https://securityplus.visafe.vn/dns-query/"
        {
            UpdateRadioStatus(num: 2)
        }
        else
        {
            UpdateRadioStatus(num: 3)
        }
        
    }
    func UpdateRadioStatus(num:Int) {
        switch num {
        case 0:
            radio0.setImage(UIImage(named: "radio_btn_on"), for: .normal)
            radio1.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio2.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio3.setImage(UIImage(named: "radio_btn_off"), for: .normal)
        case 1:
            radio1.setImage(UIImage(named: "radio_btn_on"), for: .normal)
            radio0.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio2.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio3.setImage(UIImage(named: "radio_btn_off"), for: .normal)
        case 2:
            radio2.setImage(UIImage(named: "radio_btn_on"), for: .normal)
            radio1.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio0.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio3.setImage(UIImage(named: "radio_btn_off"), for: .normal)
        case 3:
            radio3.setImage(UIImage(named: "radio_btn_on"), for: .normal)
            radio1.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio2.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            radio0.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            
        default:
            print(0)
        }
    }
    
    @IBAction func radio_default(_ sender: UIButton) {
        UpdateRadioStatus(num: 0)
        CacheManager.shared.setDnsServer(value: "https://security.visafe.vn/dns-query/")
        DoHNative.shared.onOffDoH_NoNoti(true, handleSaveSuccess)
    }
    @IBAction func radio_family(_ sender: UIButton) {
        UpdateRadioStatus(num: 1)
        CacheManager.shared.setDnsServer(value: "https://family.visafe.vn/dns-query/")
        DoHNative.shared.onOffDoH_NoNoti(true, handleSaveSuccess)
    }
    @IBAction func radio_advanced(_ sender: UIButton) {
        UpdateRadioStatus(num: 2)
        CacheManager.shared.setDnsServer(value: "https://securityplus.visafe.vn/dns-query/")
        DoHNative.shared.onOffDoH_NoNoti(true, handleSaveSuccess)
    }
    @IBAction func radio_custom(_ sender: UIButton) {
        UpdateRadioStatus(num: 3)
        CacheManager.shared.setDnsServer(value: "https://custom.visafe.vn/dns-query/")
        DoHNative.shared.onOffDoH_NoNoti(true, handleSaveSuccess)
    }
}
