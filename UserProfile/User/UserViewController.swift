//
//  UserViewController.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import UIKit
import SDWebImage

class UserViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var personaLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameValue: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameValue: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberValue: UILabel!
    @IBOutlet weak var registrationDateLabel: UILabel!
    @IBOutlet weak var viewPurchasesButton: UIButton!
    @IBOutlet weak var registrationDateValue: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Variables
    private var viewModel : UserViewModel!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.masksToBounds = true

        personaLabel.text = NSLocalizedString("Personal", comment: "")
        userNameLabel.text = NSLocalizedString("Username", comment: "")
        fullNameLabel.text = NSLocalizedString("Full name", comment: "")
        phoneNumberLabel.text = NSLocalizedString("Phone number", comment: "")
        registrationDateLabel.text = NSLocalizedString("Registration Date", comment: "")
        viewPurchasesButton.layer.cornerRadius = viewPurchasesButton.frame.height / 2
        viewPurchasesButton.layer.masksToBounds = true
        
        viewModelForUIUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData(type: UPUser.self)
    }
    
    func viewModelForUIUpdate() {
        self.viewModel =  UserViewModel(service: UserAPIService())
        self.viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        DispatchQueue.main.async {
            if let urlString = self.viewModel.user.image,
               let url = URL(string: urlString) {
                self.userImage.sd_setImage(with: url,
                                           placeholderImage: nil)
            }
            self.nameValue.text = self.viewModel.user.name
            self.userNameValue.text = self.viewModel.user.userName
            self.fullNameValue.text = self.viewModel.user.fullName
            self.phoneNumberValue.text = self.viewModel.user.phoneNumberFormatted
            self.registrationDateValue.text = "\(self.viewModel.user.registrationFormatted ?? "")"
            self.activityIndicatorView.stopAnimating()
        }
    }
    
}
