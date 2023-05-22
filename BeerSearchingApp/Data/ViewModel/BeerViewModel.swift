//
//  BeerViewModel.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation

/*struct BeerListViewModel {
    let beers: [BeerViewModel]
    
    init(from serverListModel: BeerListServerModel) {
        beers = serverListModel.beers.map { BeerViewModel(from: $0) }
    }
}*/

struct BeerViewModel {
    let uid =  UUID()
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    /*let tagline: String
    let firstBrewed: String
    
    
    let abv: Float
    let ibu: Float
    let targetFg: Int
    let targetOg: Float
    let ebc: Int
    let srm: Int
    let ph: Float
    let attenuationLevel: Float
    let volume: Volume
    let boilVolume: Volume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String*/
    
    init(serverModel: BeerServerModel) {
        id = serverModel.id ?? 0
        name = serverModel.name ?? ""
        imageUrl = serverModel.image_url ?? "https://images.punkapi.com/v2/2.png"
        description = serverModel.description ?? ""
        /*tagline = serverModel.tagline
        firstBrewed = serverModel.firstBrewed
        
        
        abv = serverModel.abv
        ibu = serverModel.ibu
        targetFg = serverModel.targetFg
        targetOg = serverModel.targetOg
        ebc = serverModel.ebc
        srm = serverModel.srm
        ph = serverModel.ph
        attenuationLevel = serverModel.attenuationLevel
        volume = serverModel.volume
        boilVolume = serverModel.boilVolume
        method = serverModel.method
        ingredients = serverModel.ingredients
        foodPairing = serverModel.foodPairing
        brewersTips = serverModel.brewersTips
        contributedBy = serverModel.contributedBy*/
    }
}

