//
//  PurchaseTableViewCell.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    static let cellHeight = CGFloat(60)

    // MARK: - Outlets
    
    @IBOutlet weak var purchaseImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        purchaseImageView.layer.cornerRadius = purchaseImageView.frame.width / 2
        purchaseImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
