//
//  BeerProvider.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation
import Alamofire
import Combine


protocol  BeerDetailProviderProtocol {
    
    func requestBeer(id: Int) -> AnyPublisher<[BeerServerModel],AFError>
}

class BeerDetailProvider : BeerDetailProviderProtocol{
    
    func requestBeer(id: Int) -> AnyPublisher<[BeerServerModel], Alamofire.AFError> {
        let url = "\(Constants.constants.baseUrl)/beers/\(id)"
        
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
