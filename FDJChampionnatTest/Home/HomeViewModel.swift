//
//  Home.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 29/09/2022.
//

import Foundation
import Combine

final class HomeViewModel {
  
  private let dependenciesProvider: HomeViewDependenciesProvider
  private(set) var autocompleteViewModel: AutocompleteViewModel = AutocompleteViewModel()
  
  @Published private(set) var teamsVM : [HomeCollectionCellViewModel] = []
  private(set) var leagues: [League] = []
  private var cancellables = Set<AnyCancellable>()
  
  init(with dependenciesProvider: HomeViewDependenciesProvider = HomeViewDependenciesProviderLive()) {
    self.dependenciesProvider = dependenciesProvider
  }
  
  enum Action {
    case launchGetAllLeaguesListRequest
    case launchGetTeamsListRequest(leagueName: String)
  }
  
  func handle(action: Action) {
    switch action {
    case .launchGetAllLeaguesListRequest:
      self.dependenciesProvider.launchGetAllLeaguesListRequest { [weak self] result in
        guard let self = self else { return }
        switch result {
        case let .success(leagues):
          guard let leagues = leagues else { return }
          self.leagues = leagues
          self.autocompleteViewModel.handle(action: .updateLeaguesList(leagues: leagues))
        case let .failure(error):
          print("error: \(error)")
        }
      }
      
    case let .launchGetTeamsListRequest(leagueName):
      self.dependenciesProvider.launchGetTeamsListRequest(leagueName: leagueName) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case let .success(teams):
          guard let teams = teams else { return }
          self.teamsVM = teams.compactMap({
            HomeCollectionCellViewModel(team: $0)
          })
        case let .failure(error):
          print("error: \(error)")
        }
      }
    }
  }
}
