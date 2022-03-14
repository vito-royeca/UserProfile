//
//  UserViewModel.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import Foundation

class UserViewModel : NSObject {
    
    private var apiService : UserAPIService!
    private(set) var user : UPUser! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  UserAPIService()
//        fetchData()
    }
    
    func fetchData() {
        self.apiService.fetchUser(completion: { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error)
            }
        })
    }
}
