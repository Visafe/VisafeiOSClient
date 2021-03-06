//
//  ConfirmDeleteView.swift
//  visafe
//
//  Created by Cuong Nguyen on 6/27/21.
//

import UIKit
import SwiftMessages

class ConfirmDeleteView: MessageViewBase {
    
    var acceptAction:(() -> Void)?
    var cancelAction:(() -> Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    class func loadFromNib() -> ConfirmDeleteView? {
        return self.loadFromNib(withName: ConfirmDeleteView.className)
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        acceptAction?()
        SwiftMessages.hide()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        cancelAction?()
        SwiftMessages.hide()
    }
}
