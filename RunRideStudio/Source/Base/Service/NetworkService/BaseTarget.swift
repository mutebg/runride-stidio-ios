//
//  BaseTarget.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

protocol BaseTarget {
    var path: String { get }
    var method: HttpMethod { get }
    var pathVariables: [CVarArg]? { get }
    var queryParameters: [String: String]? { get }
}

// MARK: - Default implementation
extension BaseTarget {
    var method: HttpMethod {
        .get
    }
    
    var pathVariables: [CVarArg]? {
        nil
    }
    
    var queryParameters: [String: String]? {
        nil
    }

    func getUrl(
        baseHost: String,
        additionalQueryParameters: [String: String]?
    ) -> URL? {
        var components: URLComponents?
        
        let pathString = buildURLPath(baseHost: baseHost, path: path)
        
        if let arguments = pathVariables, !arguments.isEmpty {
            components = URLComponents(string: String(format: pathString, arguments: arguments))
        } else {
            components = URLComponents(string: pathString)
        }

        set(queryParameters: queryParameters ?? [:], components: &components)
        set(queryParameters: additionalQueryParameters ?? [:], components: &components)

        return components?.url
    }
}

// MARK: - Private methods
extension BaseTarget {
    private func set(
        queryParameters: [String: String],
        components: inout URLComponents?
    ) {
        guard queryParameters.count > 0 else { return }
        
        let queryItems = components?.queryItems ?? []
        components?.queryItems = queryItems
        
        queryParameters.forEach { key, value in
            if !key.isEmpty && !value.isEmpty {
                components?.queryItems?.append(URLQueryItem(name: key, value: value))
            }
        }
        
        applyGlobalQueryRules(components: &components)
    }
    
    // Modify query encoding as per API specifications(prom)
    private func applyGlobalQueryRules(components: inout URLComponents?) {
        var query = components?.percentEncodedQuery
        
        query = query?.replacingOccurrences(of: ";", with: "%3B")
            .replacingOccurrences(of: "/", with: "%2F")
            .replacingOccurrences(of: ":", with: "%3A")
            .replacingOccurrences(of: "?", with: "%3F")
        
        components?.percentEncodedQuery = query
    }
    
    private func buildURLPath(baseHost: String, path: String) -> String {
        let formattedPath = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        return "\(baseHost)\(baseHost.hasSuffix("/") ? "" : "/")\(formattedPath)"
    }
}
