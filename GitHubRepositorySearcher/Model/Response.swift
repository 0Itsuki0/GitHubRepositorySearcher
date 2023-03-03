//
//  Response.swift
//  GitHubRepositorySearcher
//
//
//  Created by Itsuki on 2023/03/02.
//


import Foundation

struct Response: Codable {
    
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    
    private enum CodingKeys : String, CodingKey {
        case totalCount = "total_count", incompleteResults = "incomplete_results", items
    }
        
}
