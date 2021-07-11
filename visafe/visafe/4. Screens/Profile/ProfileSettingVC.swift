//
//  ProfileVC.swift
//  visafe
//
//  Created by Cuong Nguyen on 7/8/21.
//

import UIKit

public enum ProfileSettingEnum: Int {
    case changepass = 0
    case enterpin = 1
    case settingnoti = 2
    case language = 3
    case logout = 4
    
    func getIcon() -> UIImage? {
        switch self {
        case .changepass:
            return UIImage(named: "ic_changepass")
        case .enterpin:
            return UIImage(named: "ic_enterpin")
        case .settingnoti:
            return UIImage(named: "ic_noti")
        case .language:
            return UIImage(named: "ic_language")
        case .logout:
            return UIImage(named: "ic_logout")
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .changepass:
            return "Đổi mật khẩu"
        case .enterpin:
            return "Cập nhật mã PIN"
        case .settingnoti:
            return "Cấu hình thông báo"
        case .language:
            return "Ngôn ngữ"
        case .logout:
            return "Ngôn ngữ"
        }
    }
    
    func getContent() -> String {
        switch self {
        case .language:
            return "Tiếng Việt"
        default:
            return ""
        }
    }
}

class ProfileSettingVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sources: [ProfileSettingEnum] = [.changepass, .enterpin, .settingnoti, .language, .logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        title = "Cài đặt"
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 25
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 25
        tableView.registerCells(cells: [ProfileCell.className])
    }
}

extension ProfileSettingVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.className) as? ProfileCell else {
            return UITableViewCell()
        }
        cell.bindingData(type: sources[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = sources[indexPath.row]
        switch type {
        case .changepass:
            changePass()
        default:
            break
        }
    }
    
    func changePass() {
        let vc = ChangePasswordVC()
        navigationController?.pushViewController(vc)
    }
}

