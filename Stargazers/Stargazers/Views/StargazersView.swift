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
    
    var owner: String = ""
    var repository: String = ""
    
    private var viewModel = StargazersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stargazersTableView.delegate = self
        
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
}

// Table view
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
