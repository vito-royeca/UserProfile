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
    private var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Purchases".localizedCapitalized
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension//PurchaseTableViewCell.cellHeight
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
            cell.setData(imageURL: purchase.image,
                         purchaseDate: purchase.purchaseDateFormatted,
                         itemName: purchase.itemName?.localizedCapitalized,
                         price: purchase.priceFormatted,
                         serial: "Serial: \(purchase.serial ?? "")".localizedCapitalized,
                         productDescription: purchase.productDescription)
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
        return UITableView.automaticDimension//PurchaseTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PurchaseTableViewCell {
            cell.isDetailsShown = selectedIndexPath != indexPath
        }
    }
}
