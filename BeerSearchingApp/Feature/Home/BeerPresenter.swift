//
//  BeerPresenter.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation
import Combine
 
class BeerPresenter: BasePresenter, ObservableObject {
    @Published var beers: [BeerViewModel] = []
    @Published var text: String = ""
    @Published var error: String = ""
    var interactor: BeerInteractorInputPorotocol? { return super.baseInteractor as? BeerInteractorInputPorotocol}
    private var cancellable: Set<AnyCancellable> = []
    /*private var isSearchModelValidPublisher: AnyPublisher<Bool, Never> {
        $text
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    required init() {
        super.init()
        /*isSearchModelValidPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? "" : "La búsqueda no puede ser un campo vacío" }
            .assign(to: \.error, on: self)
            .store(in: &cancellable)*/
    }*/
    func requestBeers() {
        interactor?.requestSearch(text: "A")
    }
    func requestBeersFiltered(query: String) {
        interactor?.requestSearch(text: query)
    }
}
extension BeerPresenter: BeerInteractorOutputProtocol {
    func success(response: [BeerViewModel]) {
        self.beers = response
    }
    func error(message: String) {
        error = message
        print(error)
    }
}
