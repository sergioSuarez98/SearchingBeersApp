
import Foundation

///El server model debería recibir todos los datos que se reciben de backend. Había una serie de atributos que dependiendo de la cerveza tomaba un tipo de valor u otro, así que por falta de tiempo decidí quedarme solo con los atributos que voy a utilizar y que no dan problemas. Para el ejemplo sirve


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


