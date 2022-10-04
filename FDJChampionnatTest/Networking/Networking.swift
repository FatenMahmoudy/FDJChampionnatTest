//
//  Networking.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation
import Combine

protocol NetworkProtocol {
  func get<T>(type: T.Type,
              endpoint: AppAPI
  ) -> AnyPublisher<T, Error> where T: Decodable
}

class Networking: NetworkProtocol {
  
  func get<T>(type: T.Type, endpoint: AppAPI) -> AnyPublisher<T, Error> where T : Decodable {
    
    let urlString = endpoint.baseURL?.appendingPathComponent(endpoint.api_key + endpoint.path).absoluteString.removingPercentEncoding?.replacingOccurrences(of: " ", with: "%20")
    
    guard let urlRequest = URL(string: urlString ?? "") else {
      return Fail(outputType: T.self, failure: Error.self as! Error).eraseToAnyPublisher()
    }
    
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    
    let session = URLSession(configuration: configuration)
    
    return session.dataTaskPublisher(for: urlRequest)
      .map(\.data)
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
}
