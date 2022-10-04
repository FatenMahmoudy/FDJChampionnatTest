//
//  TeamDetailsDependenciesProvider.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 02/10/2022.
//

import Foundation
import Combine

protocol TeamDetailsDependenciesProvider {
  func launchGetTeamDetailsRequest(teamName: String, completion: @escaping (Result<Team?, Error>) -> Void)
}

final class TeamDetailsDependenciesProviderLive: TeamDetailsDependenciesProvider {
  
  private let networking = Networking()
  private var cancellables: Set<AnyCancellable> = []
  
  func launchGetTeamDetailsRequest(teamName: String, completion: @escaping (Result<Team?, Error>) -> Void) {
    self.networking.get(type: TeamsSearchResponse.self, endpoint: AppAPI.getTeamDetails(teamName: teamName))
      .sink { complete in
        switch complete {
        case let .failure(error):
          completion(.failure(error))
        case .finished:
          break
        }
      } receiveValue: { value in
        let team = value.teams?.first
        completion(.success(team))
      }.store(in: &cancellables)
  }
  
}
