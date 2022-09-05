//
//  DownloadService.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 29.08.2022.
//

import Foundation

class DownloadService {
    
    let defaultSession = URLSession(configuration: .default)
    
    
    private var imageDataTasks: [String: URLSessionDataTask] = [:]
    
    var rockets: [Rocket] = []
    var allLaunches: [Launch] = []
    var launches: [Launch] = []
    
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
            self.rockets = rocketsInfo
            completion(self.rockets)
        }
    }
    
    func fetchAllLaunchesInfo(completion: @escaping (([Launch]) -> Void)) {
        fetchInfo(from: launchesInfoURL) { (launchesInfo: [Launch]) in
            self.allLaunches = launchesInfo
            completion(self.launches)
        }
    }
    
    
    func fetchLaunchesInfoForRocket(rocketID: String, completion: @escaping ([Launch]) -> Void) {
        let url = URL(string: "https://api.spacexdata.com/v4/launches/query")!
        
        let jsonDictionary: [String: Any] = ["query": ["rocket": "\(rocketID)"], "options": ["pagination" : false]]
        print(rocketID)
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
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Server error")
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-mm-dd'T'HH:mm:ss.SSSZ"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let fetchResults = try jsonDecoder.decode(LaunchesSearchResults.self, from: data)
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
}
