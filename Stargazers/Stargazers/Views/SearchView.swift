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
        self.hideKeyboardWhenTappedAround() 
       
        // searchRepoButton settings
        searchRepoButton.layer.cornerRadius = 25
        
        ownerTextField.text = "juicycleff"
        repositoryTextField.text = "ultimate-backend"
        
    }
    
    @IBAction func SearchRepoButtonAction(_ sender: Any) {
        errorLabel.alpha = 0
        if(ownerTextField.text == "" || repositoryTextField.text == "") {
            errorLabel.alpha = 1
            errorLabel.text = "Attention! Please check if the Owner and the Repositoy are correct!"
            //print("one of the TextFields are null")
            return
        }
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StargazersView") as? StargazersView
        vc?.setOwnerAndRepo(owner: ownerTextField.text!, repository: repositoryTextField.text!)
        self.navigationController?.pushViewController(vc!, animated: true)
        //self.performSegue(withIdentifier: "resultViweSegue", sender: self)
        
        ownerTextField.text = ""
        repositoryTextField.text = ""
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
