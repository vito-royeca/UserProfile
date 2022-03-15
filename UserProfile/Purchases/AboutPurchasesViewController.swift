//
//  AboutPurchasesViewController.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import UIKit

class AboutPurchasesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "About Purchases".localizedCapitalized
        bodyLabel.text = NSLocalizedString("This screen contains your entire purchase history. You can sort it by date of purchase. You can sort it by price. And you can filter it with the search bar.", comment: "")
        
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
