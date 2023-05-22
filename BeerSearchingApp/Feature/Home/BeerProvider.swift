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
    func requestBeers(model: BeerRequestModel) -> AnyPublisher<[BeerServerModel],AFError>
}

class BeerProvider : BeerProviderProtocol{
    
    func requestBeers(model: BeerRequestModel) -> AnyPublisher<[BeerServerModel], AFError> {
        let url = "https://api.punkapi.com/v2/beers?page=2&per_page=40&food=\(model.text)"
        
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
