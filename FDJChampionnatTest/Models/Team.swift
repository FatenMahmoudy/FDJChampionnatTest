//
//  Team.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation

struct Team: Codable {
  let id: String?
  let name: String?
  let banner: String?
  let badge: String?
  let country: String?
  let championship: String?
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "idTeam"
    case name = "strTeam"
    case banner = "strTeamBanner"
    case badge = "strTeamBadge"
    case country = "strCountry"
    case championship = "strLeague"
    case description = "strDescriptionEN"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? nil
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? nil
    self.banner = try container.decodeIfPresent(String.self, forKey: .banner) ?? nil
    self.badge = try container.decodeIfPresent(String.self, forKey: .badge) ?? nil
    self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? nil
    self.championship = try container.decodeIfPresent(String.self, forKey: .championship) ?? nil
    self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? nil
  }
  
}
