//
//  PurchasesViewController.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import UIKit

class PurchasesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Variables
    private var viewModel : PurchasesViewModel!
    private var dataSource : PurchasesTableViewDataSource<PurchaseTableViewCell, UPPurchase>!
//    private var dataSource : EmployeeTableViewDataSource<EmployeeTableViewCell,EmployeeData>!
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModelForUIUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData(type: UPPurchase.self)
    }
    
    func viewModelForUIUpdate() {
        self.viewModel =  PurchasesViewModel(service: PurchasesAPIService())
        self.viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.dataSource = PurchasesTableViewDataSource(cellIdentifier: "purchaseCell",
                                                       items: viewModel.purchases,
                                                       configureCell: { (cell, purchase) in
            if let imageURL = purchase.image,
               let url = URL(string: imageURL) {
                cell.purchaseImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            }
            
            cell.titleLabel.text = purchase.itemName
            cell.subtitleLabel.text = purchase.purchaseDateFormatted
            cell.priceLabel.text = purchase.priceFormatted
        })

        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension PurchasesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PurchaseTableViewCell.cellHeight
    }
}
