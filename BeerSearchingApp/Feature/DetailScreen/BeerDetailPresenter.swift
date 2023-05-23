//
//  BeerDetailPresenter.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 23/5/23.
//

import Foundation
import Combine

class BeerDetailPresenter: BasePresenter, ObservableObject {
    @Published var beer: BeerViewModel?
    @Published var text: String = ""
    @Published var error: String = ""
    @Published var isLoading = true
    let interactor: BeerDetailInteractor
    
    
    private var cancellable: Set<AnyCancellable> = []
    
    
    required init() {
        self.interactor = BeerDetailInteractor()
        super.init()
        
        self.interactor.presenter = self
    }
    
    func requestBeer(id: Int) {
        interactor.requestBeer(id: id)
    }
    
}
extension BeerDetailPresenter: BeerDetailInteractorOutputProtocol {
    func success(response: BeerViewModel) {
        self.beer = response
        self.isLoading = false
    }
    func error(message: String) {
        error = message
        print(error)
    }
}
