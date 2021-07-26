//
//  GroupNameVC.swift
//  visafe
//
//  Created by Cuong Nguyen on 6/28/21.
//

import UIKit

class PostWorkspacesVC: BaseViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameTextfield: BaseTextField!
    @IBOutlet weak var nameInfoLabel: UILabel!
    
    var workspace: WorkspaceModel
    var editMode: EditModeEnum
    
    var onContinue:(() -> Void)?
    
    init(workspace: WorkspaceModel, editMode: EditModeEnum) {
        self.workspace = workspace
        self.editMode = editMode
        super.init(nibName: PostWorkspacesVC.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    
    func updateView() {
        nameTextfield.text = workspace.name
        updateStateButtonContinue()
        
        // title
        if editMode == .add {
            title = "Tạo tài khoản"
        } else {
            title = "Chỉnh sửa tài khoản"
        }
        
        // left
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "cancel_icon"), style: .done, target: self, action: #selector(onClickLeftButton))

        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func onClickLeftButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        if validateInfo() {
            workspace.name = nameTextfield.text?.trim()
            workspace.type = WorkspaceTypeEnum.family
            workspace.phishingEnabled = true
            workspace.malwareEnabled = true
            workspace.logEnabled = true
            showLoading()
            if editMode == .add {
                WorkspaceWorker.add(workspace: workspace) { [weak self] (result, error) in
                    guard let weakSelf = self else { return }
                    weakSelf.hideLoading()
                    weakSelf.handleResult(result: result, error: error)
                }
            } else {
                let param = WorkspaceUpdateNameParam()
                param.workspace_name = workspace.name
                param.workspace_id = workspace.id
                WorkspaceWorker.updateName(param: param) { [weak self] (result, error) in
                    guard let weakSelf = self else { return }
                    weakSelf.hideLoading()
                    weakSelf.handleUpdatename(result: result, error: error)
                }
            }
        }
    }
    
    func handleUpdatename(result: WorkspaceModel?, error: Error?) {
        if result != nil && error == nil {
            showMemssage(title: "Sửa cấu hình thành công", content: "Visafe đã sẵn sàng bảo vệ bạn") { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.parent?.dismiss(animated: true, completion: nil)
            }
        } else {
            showError(title: "Sửa cấu hình thất bại", content: "Có lỗi xảy ra, vui lòng thử lại")
        }
    }

    func handleResult(result: WorkspaceModel?, error: Error?) {
        if result != nil && error == nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationUpdateWorkspace), object: nil)
            showMemssage(title: "Tạo cấu hình thành công", content: "Visafe đã sẵn sàng bảo vệ bạn") { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.parent?.dismiss(animated: true, completion: nil)
            }
        } else {
            showError(title: "Tạo cấu hình thất bại", content: "Có lỗi xảy ra, vui lòng thử lại")
        }
    }
    
    func validateInfo() -> Bool {
        var success = true
        let name = nameTextfield.text ?? ""
        if name.isEmpty {
            nameInfoLabel.text = "Tên tài khoản không được để trống"
            success = false
        }
        return success
    }
    
    func updateStateButtonContinue() {
        if (nameTextfield.text?.count ?? 0) == 0 {
            continueButton.backgroundColor = UIColor(hexString: "F8F8F8")
            continueButton.setTitleColor(UIColor(hexString: "111111"), for: .normal)
            continueButton.isUserInteractionEnabled = false
        } else {
            continueButton.backgroundColor = UIColor.mainColorOrange()
            continueButton.setTitleColor(UIColor.white, for: .normal)
            continueButton.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func valueChanged(_ sender: BaseTextField) {
        updateStateButtonContinue()
    }
}


extension PostWorkspacesVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let field = textField as? BaseTextField else { return }
        if field.type != .error {
            field.setState(type: .active)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let field = textField as? BaseTextField else { return }
        if field.type != .error {
            field.setState(type: .normal)
        }
    }
}