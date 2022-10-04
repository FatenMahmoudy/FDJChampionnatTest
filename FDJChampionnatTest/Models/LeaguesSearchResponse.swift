//
//  LeaguesSearchResponse.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 05/10/2022.
//

import Foundation

struct LeaguesSearchResponse: Codable {
  let leagues: [League]?
  
  enum CodingKeys: String, CodingKey {
    case leagues = "leagues"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.leagues = try container.decodeIfPresent(Array.self, forKey: .leagues) ?? nil
  }
}
