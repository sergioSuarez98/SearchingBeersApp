//
//  BeerInteractor.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/05/23.
//

import Foundation
import Combine
///protocolo con las dos funciones a implementar
protocol BeerInteractorInputPorotocol: BaseInteractorInputProtocol{
    func requestBeers()
    func requestSearch(text: String)
}
///Delegados para el caso de success y error
protocol BeerInteractorOutputProtocol: BaseinteractorOutputProtocol{
    func success(response: [BeerViewModel])
    func error(message: String)
    
}

class BeerInteractor: BaseInteractor{
    var provider: BeerProviderProtocol = BeerProvider()
    weak var presenter: BeerInteractorOutputProtocol? {
        return super.basePresenter as? BeerInteractorOutputProtocol
    }
    var cancellable: Set<AnyCancellable> = []
    
}

extension BeerInteractor: BeerInteractorInputPorotocol{
    ///función donde se gestiona la lógica de negocio que debemos aplicar dependiendo de si la respuesta de la request es satisfactoria o da error.
    func requestBeers() {
        provider.requestBeers()
            .map{$0.map{BeerViewModel(serverModel: $0)}}
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("La petición de cervezas se completó correctamente.")
                case .failure(let error):
                    guard  self != nil else { return }
                    self.presenter?.error(message: error.localizedDescription)
                }
            }, receiveValue: {[weak self] response in
                guard  self != nil else { return }
                self?.presenter?.success(response: response)
                
            })
            .store(in: &cancellable)
    }
    ///función donde se gestiona la lógica de negocio que debemos aplicar dependiendo de si la respuesta de la request es satisfactoria o da error.
    func requestSearch(text: String) {
        let model = BeerRequestModel(text: text)
        
        provider.requestBeersFiltered(model: model)
            .map{$0.map{BeerViewModel(serverModel: $0)}}
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("La petición de cervezas se completó correctamente.")
                case .failure(let error):
                    guard  self != nil else { return }
                    self.presenter?.error(message: error.localizedDescription)
                }
            }, receiveValue: {[weak self] response in
                guard  self != nil else { return }
                self?.presenter?.success(response: response)
                
            })
            .store(in: &cancellable)
        
    }
    
    
    
}

