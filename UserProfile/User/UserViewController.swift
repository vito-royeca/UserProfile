//
//  UserViewController.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import UIKit
import SDWebImage

class UserViewController: UIViewController {
    
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
    @IBOutlet weak var registrationDateValue: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var viewModel : UserViewModel!
    
//    private var dataSource : EmployeeTableViewDataSource<EmployeeTableViewCell,EmployeeData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.masksToBounds = true

        personaLabel.text = "Personal".localizedCapitalized
        userNameLabel.text = "Username".localizedCapitalized
        fullNameLabel.text = "Full name".localizedCapitalized
        phoneNumberLabel.text = "Phone number".localizedCapitalized
        registrationDateLabel.text = "Registration Date".localizedCapitalized
        
        viewModelForUIUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
    }
    
    func viewModelForUIUpdate() {
        self.viewModel =  UserViewModel()
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
            self.phoneNumberValue.text = self.viewModel.user.phoneNumber
            self.registrationDateValue.text = "\(self.viewModel.user.registrationFormatted ?? "")"
            self.activityIndicatorView.stopAnimating()
        }
        
//        self.dataSource = EmployeeTableViewDataSource(cellIdentifier: "EmployeeTableViewCell", items: self.employeeViewModel.empData.data, configureCell: { (cell, evm) in
//            cell.employeeIdLabel.text = evm.id
//            cell.employeeNameLabel.text = evm.employeeName
//        })
//
//        DispatchQueue.main.async {
//            self.employeeTableView.dataSource = self.dataSource
//            self.employeeTableView.reloadData()
//        }
    }
    
}
