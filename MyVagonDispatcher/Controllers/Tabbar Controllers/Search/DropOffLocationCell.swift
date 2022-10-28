//
//  DropOffLocationCell.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 24/06/22.
//

import UIKit

class DropOffLocationCell : UITableViewCell {
    @IBOutlet weak var LblTitle: themeLabel!
    @IBOutlet weak var LblDescripiton: themeLabel!
    @IBOutlet weak var ButtonSelect: UIButton!
    override func awakeFromNib() {
        ButtonSelect.isUserInteractionEnabled = false
    }
    @IBAction func ButtonSelectAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
