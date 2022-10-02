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
  
  @Published private(set) var teamsVM : [HomeCollectionCellViewModel] = []
  private var cancellables = Set<AnyCancellable>()
  
  init(with dependenciesProvider: HomeViewDependenciesProvider = HomeViewDependenciesProviderLive()) {
    self.dependenciesProvider = dependenciesProvider
  }
  
  enum Action {
    case launchGetTeamsListRequest(leagueName: String)
  }
  
  func handle(action: Action) {
    switch action {
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
