//
//  BeerListProviderTest.swift
//  BeerSearchingAppTests
//
//  Created by Sergio Suarez on 23/5/23.
//
import XCTest
import Alamofire
import Combine
@testable import BeerSearchingApp

class BeerProviderTests: XCTestCase {
    var provider: BeerProvider!
    
    override func setUp() {
        super.setUp()
        provider = BeerProvider()
    }
    
    override func tearDown() {
        provider = nil
        super.tearDown()
    }
    
    func testRequestBeersSuccess() {
        let expectation = XCTestExpectation(description: "Request beers")
        
        
        _ = provider.requestBeers()
            .sink {[weak self] completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: {[weak self] beers in
                XCTAssertNotNil(beers, "Filtered beers should not be nil")
            }
        
    }
    
    func testRequestBeersFiltered() {
        let expectation = XCTestExpectation(description: "Request filtered beers")
        let model = BeerRequestModel(text: "pizza")
        
        provider.requestBeersFiltered(model: model)
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: { beers in
                XCTAssertNotNil(beers, "Filtered beers should not be nil")
            }
    }
}

