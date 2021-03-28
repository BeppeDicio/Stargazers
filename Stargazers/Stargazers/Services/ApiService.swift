//
//  ApiService.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 26/03/21.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getStargazersData(owner: String, repository: String, completion: @escaping (Result<[Stargazer], Error>) -> Void) {
        
        let stargazersURL = "https://api.github.com/repos/\(owner)/\(repository)/stargazers"
        
        guard let url = URL(string: stargazersURL) else {return}
        
        //Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
        
                // TODO: Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // TODO: Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                //Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Stargazer].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
