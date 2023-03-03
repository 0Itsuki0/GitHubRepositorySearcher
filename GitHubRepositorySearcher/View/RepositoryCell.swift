//
//  RepositoryCell.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    var repository: Repository!
    
    static let cellIdentifier = String(describing: RepositoryCell.self)

    
    // configure cell before adding to table
    func configure() {
        repositoryNameLabel.text = repository.fullName
        descriptionLabel.text = repository.description
        languageLabel.text = repository.language
    }
    
}
