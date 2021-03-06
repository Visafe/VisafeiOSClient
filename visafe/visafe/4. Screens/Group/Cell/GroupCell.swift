//
//  GroupCell.swift
//  visafe
//
//  Created by Cuong Nguyen on 6/23/21.
//

import UIKit

class GroupCell: BaseTableCell {

    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var numberMemberLabel: UILabel!
    
    var onMoreAction:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindingData(group: GroupModel) {
        titleLabel.text = group.name
        letterLabel.text = group.name?.getLetterString()
        numberMemberLabel.text = "\(group.usersGroupInfo.count) thành viên"
    }
    
    @IBAction func onClickMoreButton(_ sender: Any) {
        onMoreAction?()
    }
}
