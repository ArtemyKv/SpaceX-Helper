//
//  DownloadService.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 29.08.2022.
//

import Foundation
import UIKit

class DownloadService {
    
    let defaultSession = URLSession(configuration: .default)
    
    private var launches: [String: [Launch]] = [:]
    private var imagesByRocketId: [String: [UIImage]] = [:]
    
    let rocketInfoURL = URL(string: "https://api.spacexdata.com/v4/rockets")!
    let launchesInfoURL = URL(string: "https://api.spacexdata.com/v4/launches")!
    
    private func fetchInfo<T: Codable>(from url: URL, completion: @escaping (([T]) -> Void)) {
                
        let dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                print (error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Server not responding")
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let results = try jsonDecoder.decode([T].self, from: data)
                    DispatchQueue.main.async {
                        completion(results)
                    }
                } catch let error {
                    print("Error: \(error), \(error.localizedDescription)")
                }
            }
        })
        dataTask.resume()
    }
    
    func fetchRocketInfo(completion: @escaping (([Rocket]) -> Void)) {
        fetchInfo(from: rocketInfoURL) { (rocketsInfo: [Rocket]) in
            completion(rocketsInfo)
        }
    }
    
    func fetchAllLaunchesInfo(completion: @escaping (([Launch]) -> Void)) {
        fetchInfo(from: launchesInfoURL) { (launchesInfo: [Launch]) in
            completion(launchesInfo)
        }
    }
    
    
    func fetchLaunchesInfoForRocket(rocketID: String, completion: @escaping ([Launch]) -> Void) {
        if let launchesForRocketID = launches[rocketID] {
            completion(launchesForRocketID)
            return
        }
        
        let url = URL(string: "https://api.spacexdata.com/v4/launches/query")!
        
        let jsonDictionary: [String: Any] = ["query": ["rocket": "\(rocketID)"], "options": ["pagination" : false]]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = jsonData
        
        let dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error \(error), \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Server not responding")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("HTTP Error with code:\(httpResponse.statusCode)")
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-mm-dd'T'HH:mm:ss.SSSZ"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let fetchResults = try jsonDecoder.decode(LaunchesSearchResults.self, from: data)
                    self.launches[rocketID] = fetchResults.docs
                    DispatchQueue.main.async {
                        completion(fetchResults.docs)
                    }
                } catch let error {
                    print("Error: \(error), \(error.localizedDescription)")
                    
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchImages(for rocket: Rocket, completion: @escaping ([UIImage]) -> Void) {
        if let rocketImages = imagesByRocketId[rocket.id] {
            completion(rocketImages)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let imageURLs = rocket.imageURLs
            self.imagesByRocketId[rocket.id] = []
            for url in imageURLs {
                guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { continue }
                self.imagesByRocketId[rocket.id]?.append(image)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                completion(self.imagesByRocketId[rocket.id]!)
            }
        }
    }
}
