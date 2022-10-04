//
//  TeamDetailsViewModel.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 02/10/2022.
//

import Combine

final class TeamDetailsViewModel {
  
  private let dependenciesProvider: TeamDetailsDependenciesProvider
  private(set) var teamName: String
  
  @Published private(set) var team: Team?
  private var cancellables = Set<AnyCancellable>()
  
  init(with teamName: String, dependenciesProvider: TeamDetailsDependenciesProvider = TeamDetailsDependenciesProviderLive()) {
    self.teamName = teamName
    self.dependenciesProvider = dependenciesProvider
  }
  
  enum Action {
    case launchGetTeamDetailsRequest
  }
  
  func handle(action: Action) {
    switch action {
    case .launchGetTeamDetailsRequest:
      self.dependenciesProvider.launchGetTeamDetailsRequest(teamName: self.teamName) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case let .success(team):
          guard let team = team else { return }
          self.team = team
        case let .failure(error):
          print("error: \(error)")
        }
      }
    }
  }
}
