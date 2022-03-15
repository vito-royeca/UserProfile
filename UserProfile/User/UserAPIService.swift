//
//  UserAPIService.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import CoreData

class UserAPIService: BaseAPIService {

    override func fetchLocalData<T: NSManagedObject>(completion: @escaping (Result<[T], Error>) -> Void) {
        let predicate = NSPredicate(format: "userName = %@", Constants.defaultUserName)

        if let user = CoreDataManager.shared.find(UPUser.self,
                                                  properties: nil,
                                                  predicate: predicate,
                                                  sortDescriptors: nil,
                                                  createIfNotFound: false)?.first,
           let lastUpdate = user.lastUpdate,
           let diff = Calendar.current.dateComponents([.minute],
                                                         from: lastUpdate,
                                                         to: Date()).minute,
           diff <= Constants.syncThresholdMinutes {
            
            completion(.success([user as! T]))
            
        } else {
            let urlString = "https://idme-takehome.proxy.beeceptor.com/profile/U13023932"
            
            fetchRemoteData(type: UPUser.self, urlString: urlString, completion: { result in
                switch result {
                case .success:
                    if let user = CoreDataManager.shared.find(UPUser.self,
                                                              properties: ["lastUpdate": Date()],
                                                              predicate: predicate,
                                                              sortDescriptors: nil,
                                                              createIfNotFound: false)?.first {
                        
                        completion(.success([user as! T]))
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
