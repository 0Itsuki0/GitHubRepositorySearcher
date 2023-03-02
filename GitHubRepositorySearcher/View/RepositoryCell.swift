//
//  RepositoryCell.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repositoryCellView: UIView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    private var repository: Repository!
    
    static let cellIdentifier = String(describing: RepositoryCell.self)

    
    func configure(repository: Repository) {
        self.repository = repository
        repositoryNameLabel.text = repository.full_name
    }
    
}
