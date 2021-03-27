//
//  SearchView.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 25/03/21.
//

import UIKit

class SearchView: UIViewController {

    var apiService = ApiService()
    @IBOutlet weak var searchRepoButton: UIButton!
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var repositoryTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        // searchRepoButton settings
        searchRepoButton.layer.cornerRadius = 25
        
    }
    
    @IBAction func SearchRepoButtonAction(_ sender: Any) {
        errorLabel.alpha = 0
        if(ownerTextField.text == "" || repositoryTextField.text == "") {
            errorLabel.alpha = 1
            errorLabel.text = "Attention! Please check if the Owner and the Repositoy are correct!"
            print("one of the TextFields are null")
            return
        }
        /*apiService.getStargazersData { (result) in
            print(result)
        }*/
        
        //self.performSegue(withIdentifier: "resultViweSegue", sender: self)
    }
}
