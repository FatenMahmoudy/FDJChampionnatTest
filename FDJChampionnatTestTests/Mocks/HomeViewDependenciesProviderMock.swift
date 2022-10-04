//
//  File.swift
//  FDJChampionnatTestTests
//
//  Created by Faten Mahmoudi on 04/10/2022.
//

import Foundation

@testable import FDJChampionnatTest

final class HomeViewDependenciesProviderMock: HomeViewDependenciesProvider {
  
  let leagues: [League] = [
    League(with: "1234", name: "French Ligue 1", sport: "Soccer", alternateName: "Ligue 1"),
    League(with: "5678", name: "yes yes a big cup or whatever", sport: "Soccer", alternateName: "Ligue 2"),
    League(with: "9101", name: "Formula 1", sport: "Motorsport", alternateName: "Formula 1"),
    League(with: "1357", name: "Scottish Premier League", sport: "Soccer", alternateName: "Scottish Premier League")]
  
  let teams: [Team] = [
    Team(with: "2468", name: "Some Name", banner: "Some URL", badge: "And another URL", country: "Anywhere", championship: "Yaay", description: "This is some big team I guess"),
    Team(with: "1357", name: "A team", banner: "a sweet pic of the team", badge: "their badge", country: "wonderland", championship: "yes yes a big cup or whatever", description: "magical team descriptio that is only seen in a magical screen")]
  
  func launchGetAllLeaguesListRequest(completion: @escaping (Result<[League]?, Error>) -> Void) {
    return completion(.success(self.leagues))
  }
  
  func launchGetTeamsListRequest(leagueName: String, completion: @escaping (Result<[Team]?, Error>) -> Void) {
    
    let result = self.teams.filter {
      return $0.championship == leagueName
    }
    
    return completion(.success(result))
  }
}
