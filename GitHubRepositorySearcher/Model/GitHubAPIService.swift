//
//  GitHubAPIService.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import Foundation


class GitHubAPIService {
    
    enum ServiceError: Error, CustomStringConvertible {
        case urlCreation
        case network
        case badRequest
        case parsing
        
        var description: String {
            switch self {
            case .urlCreation:
                return "Something wrong with keyword entered."
            case .network:
                return "Network error: Please check on connection."
            case .badRequest:
                return "Invalid request."
            case .parsing:
                return "Error parsing response."
            }
        }
    }
    
    static func fetchRepository(for text: String) async throws -> [Repository] {
        
        guard let urlString = "https://api.github.com/search/repositories?q=\(text)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed), let url = URL(string: urlString)  else {
            throw ServiceError.urlCreation
        }
        let result = await performRequest(for: url)
        
        switch result {
        case .success(let items):
            return items
        case .failure(let error):
            throw error as ServiceError
        }
        
    }
    
    
    static private func performRequest(for url: URL) async -> (Result<[Repository], ServiceError>) {
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url, delegate: nil)
            guard let httpStatus = urlResponse as? HTTPURLResponse,  httpStatus.statusCode == 200 else { return .failure(ServiceError.badRequest)}
            return parseJSONData(data: data)
        } catch {
            return .failure(ServiceError.network)
        }
        
    }
    
    
    static private func parseJSONData(data: Data) -> (Result<[Repository], ServiceError>) {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Response.self, from: data)
            return .success(decodedData.items)

        } catch  {
            return .failure(ServiceError.parsing)
        }
        
    }
    
    
}
