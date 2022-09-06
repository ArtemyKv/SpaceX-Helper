//
//  Settings.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 31.08.2022.
//

import Foundation

class Settings {
    
    static var shared = Settings()
    
    let defaults = UserDefaults.standard
    
    private init() { }
    
    var height: Length {
        get {
            return unarchiveJSON(key: Keys.height) ?? .m
        }
        set {
            archiveJSON(value: newValue, for: Keys.height)
        }
    }
    
    var diameter: Length {
        get {
            return unarchiveJSON(key: Keys.diameter) ?? .m
        }
        set {
            archiveJSON(value: newValue, for: Keys.diameter)
        }
    }
    
    var mass: Mass {
        get {
            return unarchiveJSON(key: Keys.mass) ?? .kg
        }
        set {
            archiveJSON(value: newValue, for: Keys.mass)
        }
    }
    
    var payload: Mass {
        get {
            return unarchiveJSON(key: Keys.payload) ?? .kg
        }
        set {
            archiveJSON(value: newValue, for: Keys.payload)
        }
    }
    
    enum Length: String, CaseIterable, Codable {
        case m
        case ft
    }
    
    enum Mass: String, CaseIterable, Codable {
        case kg
        case lb
    }
    
    enum Keys {
        static let height = "height"
        static let diameter = "diameter"
        static let mass = "mass"
        static let payload = "payload"
    }
    
    func archiveJSON<T: Encodable>(value: T, for key: String) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(value)
        let dataString = String(data: data, encoding: .utf8)
        defaults.set(dataString, forKey: key)
    }
    
    func unarchiveJSON<T: Decodable>(key: String) -> T? {
        let decoder = JSONDecoder()
        guard let dataString = defaults.string(forKey: key),
              let data = dataString.data(using: .utf8) else { return nil }
        return try! decoder.decode(T.self, from: data)
    }
}
