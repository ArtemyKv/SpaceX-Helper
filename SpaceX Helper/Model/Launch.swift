//
//  Launch.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 23.08.2022.
//

import Foundation

struct Launch: Codable {
    var name: String
    var rocket: String
    var success: Bool
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case name, rocket, success
        case date = "date_utc"
    }
}

struct LaunchesSearchResults: Codable {
    var docs: [Launch]
}
