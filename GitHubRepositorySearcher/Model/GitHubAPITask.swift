//
//  GitHubAPITask.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import UIKit

class GitHubAPITask {
    var keyword: String
    var inProgress = false
    var task: URLSessionDataTask?

    init(keyword: String) {
        self.keyword = keyword
    }
    
}
