//
//  HomeViewDependenciesProvider.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation
import Combine

protocol HomeViewDependenciesProvider {
  func launchGetAllLeaguesListRequest(completion: @escaping (Result<[League]?, Error>) -> Void)
  func launchGetTeamsListRequest(leagueName: String, completion: @escaping (Result<[Team]?, Error>) -> Void)
}

final class HomeViewDependenciesProviderLive: HomeViewDependenciesProvider {
  
  private let networking = Networking()
  private var cancellables: Set<AnyCancellable> = []
  
  func launchGetAllLeaguesListRequest(completion: @escaping (Result<[League]?, Error>) -> Void) {
    self.networking.get(type: LeaguesSearchResponse.self, endpoint: AppAPI.getAllLeaguesList)
      .sink { complete in
        switch complete {
        case let .failure(error):
          completion(.failure(error))
        case .finished:
          break
        }
      } receiveValue: { value in
        completion(.success(value.leagues))
      }.store(in: &cancellables)
    
  }
  
  func launchGetTeamsListRequest(leagueName: String, completion: @escaping (Result<[Team]?, Error>) -> Void) {
    self.networking.get(type: SearchResponse.self, endpoint: AppAPI.getLeagueTeamsList(leagueName: leagueName))
      .sink { complete in
        switch complete {
        case let .failure(error):
          completion(.failure(error))
        case .finished:
          break
        }
      } receiveValue: { value in
        completion(.success(value.teams))
      }.store(in: &cancellables)
  }
  
}

final class HomeViewDependenciesProviderMock {
  
}
