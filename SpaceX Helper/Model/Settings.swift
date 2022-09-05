//
//  Settings.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 31.08.2022.
//

import Foundation

class Settings {
    
    init() {
        self.height = .m
        self.diameter = .m
        self.mass = .kg
        self.payload = .kg
    }
    
    var height: Length
    var diameter: Length
    var mass: Mass
    var payload: Mass
    
    enum Length: String, CaseIterable {
        case m
        case ft
    }
    
    enum Mass: String, CaseIterable {
        case kg
        case lb
    }
}
