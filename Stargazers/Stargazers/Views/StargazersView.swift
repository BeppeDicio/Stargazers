//
//  StargazersView.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 25/03/21.
//

import UIKit

class StargazersView: UIViewController {

    @IBOutlet weak var stargazersTableView: UITableView!
    
    private var viewModel = StargazersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadStargazersData()
    }
    
    private func loadStargazersData(){
        viewModel.fetchStargatersData {
            [weak self] in
            self?.stargazersTableView.dataSource = self
            self?.stargazersTableView.reloadData()
        }
    }
}

// Table view
extension StargazersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StargazersTableViewCell
        
        let stargater = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(stargater)
        
        return cell
    }
    
    
    
}
