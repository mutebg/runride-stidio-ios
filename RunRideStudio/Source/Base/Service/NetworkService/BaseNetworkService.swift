//
//  BaseNetworkService.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

enum BaseNetworkError: Error {
    case invalidUrl
    case invalidToken
    case invalidData(Error)
    case custom(Error)
}

enum NetworkConstants {
    static let baseHost: String = "https://api-izq36taffa-uc.a.run.app"
    static let mobile: String = baseHost + "/mobile"
    static let login: String = baseHost + "/login"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol BaseNetworkServiceProtocol {
    func request(with target: BaseTarget) async -> Result<Data, BaseNetworkError>
}

final class BaseNetworkService {
    static let shared: BaseNetworkServiceProtocol = BaseNetworkService()

    private var basePath: String {
        NetworkConstants.mobile
    }
    
    private var token: String? {
        UserDefaultsConfig.stravaToken
    }
    
    private init() {
    }
}

// MARK: - BaseNetworkServiceProtocol
extension BaseNetworkService: BaseNetworkServiceProtocol {
    func request(with target: BaseTarget) async -> Result<Data, BaseNetworkError> {
        guard let token else {
            return .failure(.invalidToken)
        }
        
        let url = target.getUrl(
            baseHost: basePath,
            additionalQueryParameters: [
                "token": token
            ]
        )
        
        guard let url else {
            return .failure(.invalidUrl)
        }
        
        return await request(url, method: target.method)
    }
}

// MARK: - Private methods
extension BaseNetworkService {
    private func request(
        _ url: URL,
        method: HttpMethod
    ) async -> Result<Data, BaseNetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return .success(data)
        } catch let error {
            return .failure(.custom(error))
        }
    }
}
