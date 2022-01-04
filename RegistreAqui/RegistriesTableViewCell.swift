//
//  RegistriesTableViewCell.swift
//  RegistreAqui
//
//  Created by Gian Carlo Mantuan on 03/01/22.
//

import UIKit

class RegistriesTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureWith(_ registry: Registry) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        labelTitle.text = registry.title
        if let createdAt = registry.createdAt {
            labelDate.text = dateFormatter.string(from: createdAt)
        }
        
    }
    
}
