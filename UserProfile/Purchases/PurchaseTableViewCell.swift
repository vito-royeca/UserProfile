//
//  PurchaseTableViewCell.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    static let cellHeight = CGFloat(140)

    // MARK: - Outlets
    
    @IBOutlet weak var purchaseImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionContentLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Variables
    var isDetailsShown = false {
        didSet {
            updateCell()
            toggleDetails()
        }
    }
    var imageURL: String?
    var purchaseDate: String?
    var itemName: String?
    var price: String?
    var serial: String?
    var productDescription: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageURL = nil
        purchaseDate = nil
        itemName = nil
        price = nil
        serial = nil
        productDescription = nil
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        purchaseImageView.layer.cornerRadius = purchaseImageView.frame.width / 2
        purchaseImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        isDetailsShown = selected
    }
    
    // MARK: Methods
    func setData(imageURL: String?,
                 purchaseDate: String?,
                 itemName: String?,
                 price: String,
                 serial: String?,
                 productDescription: String?) {
        
        self.imageURL = imageURL
        self.purchaseDate = purchaseDate
        self.itemName = itemName
        self.price = price
        self.serial = serial
        self.productDescription = productDescription
        
        updateCell()
        toggleDetails()
    }
    
    private func updateCell() {
        if let imageURL = imageURL,
           let url = URL(string: imageURL) {
            purchaseImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "purchased.circle"))
        }
        
        titleLabel.text = itemName?.localizedCapitalized
        dateLabel.text = purchaseDate
        priceLabel.text = price
        if isDetailsShown {
            serialLabel.text = serial
            descriptionLabel.text = "Description:".localizedCapitalized
            descriptionContentLabel.text = productDescription
        } else {
            serialLabel.text = nil
            descriptionLabel.text = nil
            descriptionContentLabel.text = nil
        }
    }
    
    private func toggleDetails() {
        serialLabel.isHidden = !isDetailsShown
        descriptionLabel.isHidden = !isDetailsShown
        descriptionContentLabel.isHidden = !isDetailsShown
    }

}
