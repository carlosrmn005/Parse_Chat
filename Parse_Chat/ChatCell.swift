//
//  ChatCell.swift
//  Parse_Chat
//
//  Created by macstudent on 10/11/18.
//  Copyright © 2018 Carlos Roman. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell
{
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var chatMessageLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
