//
//  File.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation

enum AppAPI {
  case getAllLeaguesList
  case getLeagueTeamsList(leagueName: String)
  case getTeamDetails(teamName: String)
}

extension AppAPI: EndpointType {
  
  var api_key: String {
    return "/50130162"
  }
  
  var baseURL: URL? {
    return URL.init(string: "https://www.thesportsdb.com/api/v1/json")
  }
  
  var path: String {
    switch self {
    case .getAllLeaguesList:
      return "/all_leagues.php"
      
    case let .getLeagueTeamsList(leagueName):
      return "/search_all_teams.php?l=\(leagueName)"
      
    case let .getTeamDetails(teamName):
      return "/searchteams.php?t=\(teamName)"
    }
    
  }
}
