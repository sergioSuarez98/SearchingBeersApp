//
//  BeerProvider.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation
import Alamofire
import Combine


protocol  BeerProviderProtocol {
    func requestBeersFiltered(model: BeerRequestModel) -> AnyPublisher<[BeerServerModel],AFError>
    func requestBeers() -> AnyPublisher<[BeerServerModel],AFError>
}

class BeerProvider : BeerProviderProtocol{
    /// Implementación usando alamofire y combine. Le puse la paginación para que la app no cargue más de 20 objetos y evitar que tarde mucho en cargar. Pero la lista no se scrollea llamando a la next page por falta de tiempo.
    /// No se le pasa ningún parámetro de búsqueda ya que esta request nos da todas las cervezas ya que en la documentación de la api, indica que si el parámetro food lo pasamos vacío la api nos va a dar un error 400 bad request. Así que para evitar eso, primero llamo a todo el listado.
    func requestBeers() -> AnyPublisher<[BeerServerModel], Alamofire.AFError> {
        let url = "\(Constants.constants.baseUrl)/beers?page=1&per_page=20"
        
        return AF.request(url, method: .get)
            .publishData()
            .tryMap { response -> Data in
                guard let data = response.data else {
                    throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
                return data
            }
            .decode(type: [BeerServerModel].self, decoder: JSONDecoder())
            .mapError { error -> AFError in
                print(error)
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
            }
            .eraseToAnyPublisher()
    }
    
    ///Esta es la request que se llama cuando estamos usando el buscador. La comprobación de la url se hace para que si la barra de búsqueda está vacía, no de error, ya que la api funciona de manera que si el parámetro food = " " da un error 400
    ///El parámetro model contiene el texto que se le añade a la url
    func requestBeersFiltered(model: BeerRequestModel) -> AnyPublisher<[BeerServerModel], AFError> {
        var url = "\(Constants.constants.baseUrl)"
        if(!model.text.isEmpty){
            url += "/beers?page=1&per_page=40&food=\(model.text)"
        }else{
            url += "/beers"
        }
        
        return AF.request(url, method: .get)
            .publishData()
            .tryMap { response -> Data in
                guard let data = response.data else {
                    throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
                return data
            }
            .decode(type: [BeerServerModel].self, decoder: JSONDecoder())
            .mapError { error -> AFError in
                print(error)
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    
}
