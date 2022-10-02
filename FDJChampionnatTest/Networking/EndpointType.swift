//
//  File.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation

protocol EndpointType {
  var baseURL: URL? { get }
  var path: String { get }
  var api_key: String { get }
}
