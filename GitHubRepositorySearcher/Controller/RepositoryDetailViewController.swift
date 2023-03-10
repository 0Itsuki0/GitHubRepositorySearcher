//
//  RepositoryDetailViewController.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import UIKit
import SDWebImage

class RepositoryDetailViewController: UIViewController {
    
    var repository: Repository!
    static let controllerIdentifier = String(describing: RepositoryDetailViewController.self)
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var openIssuesCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var stargazersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // configure labels and images when view loads up
    private func configure() {
        
        if let url = repository.avatarImageUrl {
            avatarImageView.sd_setImage(with: url, completed: nil)
        } else {
            avatarImageView.image = UIImage(systemName: "square.slash")
        }
        
        repositoryNameLabel.text = repository.fullName
        descriptionLabel.text = repository.description
        languageLabel.text = repository.language ?? "Not Specified"
        openIssuesCountLabel.text = "\(repository.openIssues ?? 0)"
        watchersCountLabel.text = "\(repository.watchersCount ?? 0)"
        stargazersCountLabel.text = "\(repository.stargazersCount ?? 0)"
        forksCountLabel.text = "\(repository.forks ?? 0)"

    }

}
