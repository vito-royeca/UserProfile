//
//  BaseViewModel.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import CoreData

class BaseViewModel : NSObject {
    
    private var service : BaseAPIService!
    var bindViewModelToController : (() -> ()) = {}
    
    init(service: BaseAPIService) {
        super.init()
        self.service = service
    }
    
    func fetchData<T: NSManagedObject>(type: T.Type) {
        service.fetchLocalData(type: type, completion: { result in
            self.handle(result: result)
        })
    }
    
    func handle<T: NSManagedObject>(result: Result<[T], Error>) {
        // subclass implementation
    }
}
