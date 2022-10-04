//
//  TeamDetailsDependenciesProviderMock.swift
//  FDJChampionnatTestTests
//
//  Created by Faten Mahmoudi on 05/10/2022.
//

import Foundation

@testable import FDJChampionnatTest

final class TeamDetailsDependenciesProviderMock: TeamDetailsDependenciesProvider {
  func launchGetTeamDetailsRequest(teamName: String, completion: @escaping (Result<FDJChampionnatTest.Team?, Error>) -> Void) {
    
    let team = Team(with: "1357", name: "A team", banner: "a sweet pic of the team", badge: "their badge", country: "wonderland", championship: "yes yes a big cup or whatever", description: "magical team descriptio that is only seen in a magical screen")
    
    return completion(.success(team))
  }
  
  
}
