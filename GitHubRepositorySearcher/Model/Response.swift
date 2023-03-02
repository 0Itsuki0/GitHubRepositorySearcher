//
//  Response.swift
//  GitHubRepositorySearcher
//
//
//  Created by Itsuki on 2023/03/02.
//


import Foundation

struct Response: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [Repository]
}
