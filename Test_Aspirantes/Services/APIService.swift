//
//  APIService.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 04/01/21.
//

import Alamofire
import Foundation

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

enum ErrorsApi: String, Error {
    case invalidUser = "Ocurrió un error, por favor intenta más tarde."
}

public class APIService: NSObject {
    func getAuthorizationUser(
        user: String,
        password: String,
        completion: @escaping (Result<Authorization, ErrorsApi>) -> Void) {
        let sourcesURL: EndPointUrl = .authorization
        let headers: HTTPHeaders = [
            "api_key": apiKey,
        ]
        let parameters: [String: String] = [
            "country_code": "MX",
            "username": "\(user)",
            "password": "\(password)",
            "grant_type": "password",
            "client_id": "IATestCandidate",
            "client_secret": "c840457e777b4fee9b510fbcd4985b68",
        ]
        AF.request(sourcesURL.rawValue,
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .httpBody),
                   headers: headers)
            .validate()
            .responseDecodable(of: Authorization.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(.invalidUser))
                    guard let errorDescription = error.errorDescription else { return }
                    debugPrint("Failure: \(errorDescription)")
                }
            }
    }

    func getProfileByUser(completion: @escaping (Result<Profile, ErrorsApi>) -> Void) {
        let headers: HTTPHeaders = [
            "api_key": apiKey,
            "Authorization": "Bearer \(Defaults.getUserDetailOf().accessToken)",
        ]
        let sourcesURL: EndPointUrl = .profile
        AF.request(sourcesURL.rawValue,
                   method: .get,
                   headers: headers)
            .validate()
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(.invalidUser))
                    guard let errorDescription = error.errorDescription else { return }
                    debugPrint("Failure: \(errorDescription)")
                }
            }
    }
}
