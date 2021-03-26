//
//  SearchView.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 25/03/21.
//

import UIKit

class SearchView: UIViewController {

    var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func SearchRepoButtonAction(_ sender: Any) {
        
        apiService.getStargazersData { (result) in
            print(result)
        }
        
        //self.performSegue(withIdentifier: "resultViweSegue", sender: self)
    }
}
