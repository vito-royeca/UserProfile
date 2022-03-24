//
//  BaseAPIService.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import Combine
import CoreData

class BaseAPIService {
    private var cancellable: AnyCancellable?
    
    func fetchLocalData<T: NSManagedObject>(type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        // subclass implementation
    }
    
    func fetchRemoteData<T: Codable>(type: T.Type, urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(UPError.urlFormat))
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.jsonDateFormat
        formatter.locale = Locale(identifier: Constants.jsonLocale)
        
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { output in
            guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw UPError.statusCode
            }
            
            return output.data
        }
        .decode(type: type, decoder: decoder)
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { (subscriberCompletion) in
            switch subscriberCompletion {
            case .finished:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }, receiveValue: { jsonData in
            CoreDataManager.shared.syncToCoreData(jsonData)
        })
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: Constants.managedObjectContext)!
}
