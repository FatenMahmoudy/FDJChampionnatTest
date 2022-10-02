//
//  HomeCollectionCellViewModel.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 30/09/2022.
//

import Foundation

final class HomeCollectionCellViewModel {
  
  private let team: Team
  
  var badgeURL: URL? {
    return URL(string: self.team.badge ?? "")
  }
  
  var teamName: String {
    return self.team.name ?? ""
  }
  
  init(team: Team) {
    self.team = team
  }
}

extension HomeCollectionCellViewModel: Equatable, Hashable {
  static func == (lhs: HomeCollectionCellViewModel, rhs: HomeCollectionCellViewModel) -> Bool {
    return lhs.team.id == rhs.team.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.team.id)
  }
}
