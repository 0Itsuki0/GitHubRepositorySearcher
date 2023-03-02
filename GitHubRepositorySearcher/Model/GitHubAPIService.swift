//
//  GitHubAPIService.swift
//  GitHubRepositorySearcher
//
//  Created by Itsuki on 2023/03/02.
//

import Foundation


class GitHubAPIService {
    
    private static var task: URLSessionTask?

    enum ServiceError: Error, CustomStringConvertible {
        case urlCreation
        case network
        case parsing
        
        var description: String {
            switch self {
            case .urlCreation:
                return "Something wrong with keyword entered."
            case .network:
                return "Network error: Please check on connection."
            case .parsing:
                return "Error parsing response."
            }
        }
    }
    

    static func fetchRepository(for text: String, completionHandler: @escaping (Result<[Repository], ServiceError>) -> Void) {
        if !text.isEmpty {

            let urlString = "https://api.github.com/search/repositories?q=\(text)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(ServiceError.urlCreation))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
                if err != nil {
                    completionHandler(.failure(ServiceError.network))
                    return
                }

                guard let safeData = data else {return}
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(Response.self, from: safeData)
                    completionHandler(.success(decodedData.items))

                } catch  {
                    completionHandler(.failure(ServiceError.parsing))
                }
            }
            task.resume()
        }
    }

        static func taskCancel() {
            task?.cancel()
        }
    
    
}
