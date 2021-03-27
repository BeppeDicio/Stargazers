//
//  StargazersViewModel.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 26/03/21.
//

import Foundation

class StargazersViewModel {
    
    private var apiService = ApiService()
    private var stargazers = Array<Stargazer>()
    
    func fetchStargatersData(owner: String, repository: String, completion: @escaping () -> ()) {
        
        apiService.getStargazersData(owner: owner, repository: repository) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.stargazers = listOf
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if stargazers.count != 0 {
            return stargazers.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Stargazer {
        return stargazers[indexPath.row]
    }
}
