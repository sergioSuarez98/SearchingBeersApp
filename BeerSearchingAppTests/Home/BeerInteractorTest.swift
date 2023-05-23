//
//  BeerInteractorTest.swift
//  BeerSearchingAppTests
//
//  Created by Sergio Suarez on 23/5/23.
import XCTest
import Alamofire
import Combine
@testable import BeerSearchingApp


final class BeerInteractorTests: XCTestCase {
    
    var sut: BeerInteractor!
    var mockPresenter: MockBeerPresenter!
    private var exp: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockBeerCoordinator.build()
        sut = BeerInteractor()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    func test_interactor_conformsTo_BaseInteractor() {
        XCTAssertTrue(sut === sut as BaseInteractor)
    }
    
    func test_request_beers() {
        //given
        exp = expectation(description: "GetBeersSuccess")
        mockPresenter.initExpectation(exp: exp)
        //when
        mockPresenter.requestBeers()
        waitForExpectations(timeout: 2)
        //then
        XCTAssertEqual(mockPresenter.getSuccess, true)
    }
    func test_request_beers_filtered_success() {
        //given
        exp = expectation(description: "GetBeersFilterSuccess")
        mockPresenter.initExpectation(exp: exp)
        //when
        mockPresenter.requestBeersFilteres(query: "Spi")
        waitForExpectations(timeout: 2)
        //then
        XCTAssertEqual(mockPresenter.getSuccess, true)
    }
    
    func test_request_beers_filtered_empty() {
        //given
        exp = expectation(description: "GetBeersFilterWithoutQuery")
        mockPresenter.initExpectation(exp: exp)
        //when
        mockPresenter.requestBeersFilteres(query: "")
        waitForExpectations(timeout: 2)
        //then
        XCTAssertEqual(mockPresenter.getSuccess, true)
    }
    
    
    
}

class MockBeerPresenter: BasePresenter, BeerInteractorOutputProtocol {
    
    var exp: XCTestExpectation?
    var getSuccess: Bool = false
    var getError: Bool = false
    var interactor: BeerInteractorInputPorotocol? {
        return super.baseInteractor as? BeerInteractorInputPorotocol
    }
    
    func initExpectation(exp: XCTestExpectation) {
        self.exp = exp
    }
    
    func success(response: [BeerSearchingApp.BeerViewModel]) {
        self.getSuccess = true
        exp?.fulfill()
    }
    
    func error(message: String) {
        self.getError = true
        exp?.fulfill()
    }
    
    func requestBeers(){
        interactor?.requestBeers()
    }
    
    func requestBeersFilteres(query: String){
        interactor?.requestSearch(text: query)
    }
    
    
}

class MockBeerCoordinator: BaseCoordinator {
    static func build() -> MockBeerPresenter {
        let vip = BaseCoordinator.assembly(presenter: MockBeerPresenter.self, interactor: BeerInteractor.self)
        return vip.presenter
    }
}
