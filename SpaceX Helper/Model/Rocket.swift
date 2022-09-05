//
//  Rocket.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 23.08.2022.
//

import Foundation

struct Rocket: Codable {
    var name: String
    var id: String
    
    var height: Length
    var diameter: Length
    var mass: Mass
    var payloads: [Payload]
    
    var firstFlightDate: Date
    var country: String
    var costPerLaunch: Double
    
    var firstStage: Stage
    var secondStage: Stage
    
    var imageURLs: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, id, height, diameter, mass
        case payloads = "payload_weights"
        case firstFlightDate = "first_flight"
        case country
        case costPerLaunch = "cost_per_launch"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case imageURLs = "flickr_images"
    }
    
}

struct Length: Codable, Hashable {
    var meters: Double
    var feet: Double
}

struct Mass: Codable, Hashable {
    var kg: Double
    var lb: Double
}

struct Stage: Codable {
    var enginesCount: Double
    var fuelAmount: Double
    var burnTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case enginesCount = "engines"
        case fuelAmount = "fuel_amount_tons"
        case burnTime = "burn_time_sec"
    }
}

struct Payload: Codable, Hashable {
    var id: String
    var kg: Double
    var lb: Double
}

