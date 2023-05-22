// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let beeerServerModel = try? JSONDecoder().decode(BeeerServerModel.self, from: jsonData)

import Foundation


// MARK: - BeeerServerModelElement
struct BeerServerModel: Codable {
    let id: Int?
    let name, description: String?
    let image_url: String?
    

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case image_url
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double?
    let unit: String?
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]?
    let hops: [Hop]?
    let yeast: String?
}

// MARK: - Hop
struct Hop: Codable {
    let name: String?
    let amount: BoilVolume?
    let add, attribute: String?
}

// MARK: - Malt
struct Malt: Codable {
    let name: String?
    let amount: BoilVolume?
}


// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume?
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume?

}

typealias BeeerServerModel = [BeerServerModel]

// MARK: - Encode/decode helpers

