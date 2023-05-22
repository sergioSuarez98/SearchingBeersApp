//
//  NasaImagesInteractor.swift
//  AppFormacion
//
//  Created by Sergio Suarez on 22/05/23.
//

import Foundation
import Combine

protocol BeerInteractorInputPorotocol: BaseInteractorInputProtocol{
    func requestSearch(text: String)
}
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
    func requestSearch(text: String) {
        let model = BeerRequestModel(text: text)
        
        provider.requestBeers(model: model)
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
    
