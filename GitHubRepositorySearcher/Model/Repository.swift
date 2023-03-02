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
    let fullName: String
    let owner: Owner
    let description: String?
    
    let createdDateTimeString: String?
    let updatedDateTimeString: String?
    
    let stargazersCount: Int?
    let language: String?
    let forks: Int?
    let openIssues: Int?
    let watchersCount: Int?

    var avatarImageUrl: URL? {
        return URL(string: owner.avatarURL ?? "") ?? nil
    }
    
    var createdDate: String? {
        return formatDateTime(dateTimeString: createdDateTimeString)
    }
    var updatedDate: String? {
        return formatDateTime(dateTimeString: updatedDateTimeString)
    }
    
    
    private enum CodingKeys : String, CodingKey {
        case id, fullName = "full_name", owner, description, createdDateTimeString = "created_at", updatedDateTimeString = "updated_at" , stargazersCount = "stargazers_count", language, forks, openIssues = "open_issues", watchersCount = "watchers_count"
    }
    
    
    // format time string in yyyy-MM-ddTHH:mm:ssZ format to yyyy/MM/dd format
    private func formatDateTime(dateTimeString: String?) -> String? {
        guard let dateTimeString = dateTimeString else { return nil }

        let formatter_StringToDate = DateFormatter()
        formatter_StringToDate.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let time_dateTime = formatter_StringToDate.date(from: dateTimeString)
        
        guard let time_dateTime = time_dateTime else { return nil }
        
        let formatter_DateToString = DateFormatter()
        formatter_DateToString.dateFormat = "yyyy/MM/dd"
        let formattedDateTime = formatter_DateToString.string(from: time_dateTime)
        
        return formattedDateTime
    }
    
}

struct Owner: Codable {
    let id: Int
    let avatarURL: String?
    let url: String?
    
    private enum CodingKeys : String, CodingKey {
        case id, avatarURL = "avatar_url", url
    }
}
