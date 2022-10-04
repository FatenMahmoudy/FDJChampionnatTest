//
//  League.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 03/10/2022.
//

import Foundation

struct League: Codable {
  let id: String?
  let name: String?
  let sport: String?
  let alternateName: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "idLeague"
    case name = "strLeague"
    case sport = "strSport"
    case alternateName = "strLeagueAlternate"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? nil
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? nil
    self.sport = try container.decodeIfPresent(String.self, forKey: .sport) ?? nil
    self.alternateName = try container.decodeIfPresent(String.self, forKey: .alternateName) ?? nil
  }
}
