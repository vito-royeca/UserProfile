//
//  PurchasesAPIService.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import CoreData

class PurchasesAPIService: BaseAPIService {

    override func fetchLocalData<T: NSManagedObject>(type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        let predicate = NSPredicate(format: "user.userName = %@", Constants.defaultUserName)
        let sortDescriptors = [NSSortDescriptor(key: "lastUpdate", ascending: false)]
        
        if let purchases = CoreDataManager.shared.find(type,
                                                       properties: nil,
                                                       predicate: predicate,
                                                       sortDescriptors: sortDescriptors,
                                                       createIfNotFound: false),
           let purchase = purchases.first as? UPPurchase,
           let lastUpdate = purchase.lastUpdate,
           let diff = Calendar.current.dateComponents([.minute],
                                                         from: lastUpdate,
                                                         to: Date()).minute,
           diff <= Constants.syncThresholdMinutes {
            
            completion(.success(purchases))
            
        } else {
            let urlString = "https://idme-takehome.proxy.beeceptor.com/purchases/U13023932?page=1"
            
            fetchRemoteData(type: [PurchaseJSON].self, urlString: urlString, completion: { result in
                switch result {
                case .success:
                    if let user = CoreDataManager.shared.find(UPUser.self,
                                                              properties: nil,
                                                              predicate: NSPredicate(format: "userName = %@", Constants.defaultUserName),
                                                              sortDescriptors: nil,
                                                              createIfNotFound: false)?.first,
                        let purchases = CoreDataManager.shared.find(type,
                                                                    properties: ["user": user,
                                                                                 "lastUpdate": Date()],
                                                                   predicate: nil,
                                                                   sortDescriptors: sortDescriptors,
                                                                   createIfNotFound: false) {
                        
                        completion(.success(purchases))
                    } else {
                        completion(.failure(UPError.dataNotFound))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
}
