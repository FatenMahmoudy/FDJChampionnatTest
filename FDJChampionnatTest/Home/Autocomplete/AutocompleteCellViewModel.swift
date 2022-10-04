//
//  AutocompleteCellViewModel.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 04/10/2022.
//


struct AutocompleteCellViewModel {
  
  private(set) var league: League
  
  var label: String {
    return self.league.name ?? ""
  }
  
  init(item: League) {
    self.league = item
  }
}


extension AutocompleteCellViewModel: Equatable, Hashable {
  static func == (lhs: AutocompleteCellViewModel, rhs: AutocompleteCellViewModel) -> Bool {
    return lhs.league.id == rhs.league.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.league.id)
  }
}
