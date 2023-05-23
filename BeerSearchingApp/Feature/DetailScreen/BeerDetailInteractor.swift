
//
//  NasaImagesInteractor.swift
//  AppFormacion
//
//  Created by Sergio Suarez on 22/05/23.
//

import Foundation
import Combine

protocol BeerDetailInteractorInputPorotocol: BaseInteractorInputProtocol{
    func requestBeer(id: Int)
}
protocol BeerDetailInteractorOutputProtocol: BaseinteractorOutputProtocol{
    func success(response: BeerViewModel)
    func error(message: String)
    
}

class BeerDetailInteractor: BaseInteractor{
    var provider: BeerDetailProviderProtocol = BeerDetailProvider()
    weak var presenter: BeerDetailInteractorOutputProtocol?
    var cancellable: Set<AnyCancellable> = []
    
}

extension BeerDetailInteractor: BeerDetailInteractorInputPorotocol{
    
    func requestBeer(id: Int) {
        provider.requestBeer(id: id)
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
                guard let singleObject = response.first else{return}
                self?.presenter?.success(response: singleObject)
                
            })
            .store(in: &cancellable)
    }
    
}

