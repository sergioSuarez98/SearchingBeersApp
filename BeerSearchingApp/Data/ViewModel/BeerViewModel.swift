//
//  BeerViewModel.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation

///View model utilizado  para representar el objeto que se utilizará en la vista
struct BeerViewModel:Identifiable {
    let uid =  UUID()
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    
    init(serverModel: BeerServerModel) {
        id = serverModel.id ?? 0
        name = serverModel.name ?? ""
        imageUrl = serverModel.image_url ?? "https://images.punkapi.com/v2/2.png"
        description = serverModel.description ?? ""
        
    }
}

