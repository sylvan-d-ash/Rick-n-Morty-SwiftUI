//
//  DataService.swift
//  Rick n Morty Characters
//
//  Created by Sylvan Ash on 03/12/2024.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var parameters: [String: Any]? { get }
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}

protocol APIClient {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async -> Result<T, Error>
}

final class URLSessionAPIClient: APIClient {
    private let baseUrl = "https://rickandmortyapi.com/api"

    func request<T: Decodable>(_ endpoint: APIEndpoint) async -> Result<T, Error> {
        guard var url = URL(string: baseUrl) else {
            return .failure(URLError(.badURL))
        }
        url = url.appending(path: endpoint.path)

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return .failure(URLError(.badURL))
        }
        components.queryItems = getQueryItems(for: endpoint.parameters)

        guard let url = components.url else {
            return .failure(URLError(.badURL))
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(T.self, from: data)
            return .success(response)
        } catch _ as DecodingError {
            return .failure(APIError.invalidData)
        } catch {
            return .failure(APIError.invalidResponse)
        }
    }

    private func getQueryItems(for parameters: [String: Any]?) -> [URLQueryItem]? {
        return parameters?.map { key, value in
            var stringValue: String?

            switch value {
            case let string as String:
                stringValue = string
            case let number as NSNumber:
                stringValue = number.stringValue
            case let array as [Any]:
                // Convert array to comma-separated string
                stringValue = array.map { "\($0)" }.joined(separator: ",")
            case let bool as Bool:
                stringValue = bool ? "true" : "false"
            default:
                // Skip unsupported types
                break
            }

            return URLQueryItem(name: key, value: stringValue)
        }
    }
}
