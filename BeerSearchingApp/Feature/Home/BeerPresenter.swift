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
    func requestBeers() {
        interactor?.requestBeers()
    }
    func requestBeersFiltered(query: String) {
        interactor?.requestSearch(text: query)
    }
}
///aquí aplicamos la lógica a los delegados, que lo que van a hacer es conectar los datos recibidos en el interactor con la vista.
extension BeerPresenter: BeerInteractorOutputProtocol {
    func success(response: [BeerViewModel]) {
        self.beers = response
    }
    func error(message: String) {
        error = message
        print(error)
    }
}
