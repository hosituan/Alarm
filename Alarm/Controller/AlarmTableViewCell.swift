//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Hồ Sĩ Tuấn on 6/26/20.
//  Copyright © 2020 Hồ Sĩ Tuấn. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var statusSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
