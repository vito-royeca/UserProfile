//
//  UserProfileTests.swift
//  UserProfileTests
//
//  Created by Vito Royeca on 3/14/22.
//

import XCTest
@testable import UserProfile
@testable import SDWebImage

class UserProfileTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFetchUser() {
        let expectation = XCTestExpectation(description: "testFetchUser")
        
        let service = UserAPIService()
        
        service.fetchLocalData(type: UPUser.self, completion: { result in
            switch result {
            case .success(let users):
                let user = users.first
                XCTAssert(user != nil)
                
                XCTAssert(user?.userName == Constants.defaultUserName)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchPurchases() {
        let expectation = XCTestExpectation(description: "testFetchPurchase")
        
        let service = PurchasesAPIService()
        
        service.fetchLocalData(type: UPUser.self, completion: { result in
            switch result {
            case .success(let purchases):
                XCTAssert(purchases.count > 0)
                
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
}
