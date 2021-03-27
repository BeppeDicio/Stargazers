//
//  StargazersTableViewCell.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 26/03/21.
//

import UIKit

class StargazersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    private var urlString: String = ""
    
    // Setup movies values
    func setCellWithValuesOf(_ stargazer: Stargazer){
        updateUI(username: stargazer.login, avatarImage: stargazer.avatarURL)
    }
    
    // Update the UIViews
    private func updateUI(username: String?, avatarImage: String?){
        self.usernameLabel.text = username
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.layer.masksToBounds = false
        avatarImageView.clipsToBounds = true
        
        guard let avatarString = avatarImage else {return}
        urlString = avatarString
        
        guard let avatarImageURL = URL(string: urlString) else {
            self.avatarImageView.image = UIImage(named: "DefaultAvatar")
            return
        }
        
        // Before downloading the new one we clear the old one
        self.avatarImageView.image = nil
        
        getImageDataFrom(url: avatarImageURL)
        
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.avatarImageView.image = image
                }
            }
        }.resume()
    }
}
