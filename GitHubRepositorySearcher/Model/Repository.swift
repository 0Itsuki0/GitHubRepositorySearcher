//
//  Repository.swift
//  GitHubRepositorySearcher
//
//
//  Created by Itsuki on 2023/03/02.
//


import Foundation


struct Repository: Codable {
    let id: Int
    let full_name: String
    let owner: Owner
    let description: String?
    
    let stargazers_count: Int
    let language: String?
    let forks: Int
    let open_issues: Int
    let watchers_count: Int

    var avatarImageUrl: URL? {
        return URL(string: owner.avatar_url ?? "") ?? nil
    }
}

struct Owner: Codable {
    let id: Int
    let avatar_url: String?
    let url: String?
}
