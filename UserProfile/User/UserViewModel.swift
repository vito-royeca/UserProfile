//
//  UserViewModel.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import CoreData

class UserViewModel : BaseViewModel {
    private(set) var user: UPUser! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    override func handle<T: NSManagedObject>(result: Result<[T], Error>) {
        switch result {
        case .success(let data):
            if let user = data.first as? UPUser {
                self.user = user
            } else {
                
            }
        case .failure(let error):
            sendErrorToController(error)
        }
    }
}
