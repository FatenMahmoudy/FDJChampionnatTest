//
//  SearchResponse.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation

struct SearchResponse: Codable {
  let teams: [Team]?
  
  enum CodingKeys: String, CodingKey {
    case teams = "teams"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.teams = try container.decodeIfPresent(Array.self, forKey: .teams) ?? nil
  }
}
