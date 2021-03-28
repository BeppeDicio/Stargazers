//
//  StargazersView.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 25/03/21.
//

import UIKit

class StargazersView: UIViewController {

    @IBOutlet weak var stargazersTableView: UITableView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var owner: String = ""
    var repository: String = ""
    
    private var viewModel = StargazersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stargazersTableView.delegate = self
        self.errorLabel.alpha = 0;
        self.loaderView.alpha = 1;
        updateData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    private func loadStargazersData(){
        viewModel.fetchStargatersData(owner: owner, repository: repository) {
            [weak self] in
            self?.stargazersTableView.dataSource = self
            self?.stargazersTableView.reloadData()
        }
    }
    
    public func setOwnerAndRepo(owner: String, repository: String){
        self.owner = owner
        self.repository = repository
        
    }
    
    private func updateData() {
        
        self.ownerLabel?.text = owner
        self.repoLabel?.text = repository
        loadStargazersData()
    }
    
    private func updateErrorLabel(bool: Bool) {
        if bool {
            errorLabel.text = "We are sorry! No Stargazers found for the asked repository. Check if the name of the Owner or the Repository are correct!"
            errorLabel.alpha = 1;
        } else {
            self.loaderView.alpha = 0
        }
    }
}

// Table view
// TODO: Manage empty results
// TODO: Manage api errors from name errors on the Owner and Repo String
extension StargazersView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StargazersTableViewCell
        cell.accessoryType = .detailDisclosureButton
        let stargater = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(stargater)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.updateErrorLabel(bool: false)
    }
}

extension StargazersView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stargater = viewModel.cellForRowAt(indexPath: indexPath)
        self.performSegue(withIdentifier: "webViewSegue", sender: stargater.htmlURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "webViewSegue") {
            if let vc = segue.destination as? StargazersDetailPopOver, let detailToSend = sender as? String {
                vc.setUrl(url: detailToSend)
            }
        }
    }
}
