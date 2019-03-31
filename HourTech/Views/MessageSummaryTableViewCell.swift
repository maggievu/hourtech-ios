//
//  MessageSummaryTableViewCell.swift
//  HourTech
//
//  Created by Noppawit Hansompob on 27/3/2562 BE.
//  Copyright © 2562 Maggie VU. All rights reserved.
//

import UIKit

class MessageSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var latestDatetimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        fullnameLabel.text = ""
        titleLabel.text = ""
    }
    
    func configurateCell(_ chatSummaryInfo: ChatSummary) {
        fullnameLabel.text = chatSummaryInfo.firstname + " " + chatSummaryInfo.lastname
        titleLabel.text = chatSummaryInfo.title
        
        let date = Date(timeIntervalSince1970: chatSummaryInfo.latestTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM d, h:mm a"
        
        latestDatetimeLabel.text = dateFormatter.string(from: date)
        
    }

}
