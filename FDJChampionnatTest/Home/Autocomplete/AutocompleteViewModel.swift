//
//  AutocompleteViewModel.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 04/10/2022.
//

import Foundation
import Combine

final class AutocompleteViewModel {
  
  private(set) var delegate: AutocompleteProtocol? = nil
  @Published private(set) var leaguesVM : [AutocompleteCellViewModel] = []
  
  private var leagues: [League] = []
  
  enum Action {
    case updateLeaguesList(leagues: [League])
    case userDidTapOnItem(league: League)
    case setSearchQuery(String)
  }
  
  init() {}
  
  private func updateSearchList(query: String) {
    let vms = leagues.filter { (league: League) -> Bool in
      let nameMatch = league.name?.range(of: query, options: NSString.CompareOptions.caseInsensitive)
      let alternateNameMatch = league.alternateName?.range(of: query, options: NSString.CompareOptions.caseInsensitive)
      
      return nameMatch != nil || alternateNameMatch != nil
    }.map { AutocompleteCellViewModel(item: $0) }
    
    self.leaguesVM = vms
  }
  
  func configure(delegate: AutocompleteProtocol){
    self.delegate = delegate
  }
  
  func handle(action: Action) {
    switch action {
    case let .updateLeaguesList(leagues):
      self.leagues = leagues
      
    case let .userDidTapOnItem(league):
      self.delegate?.didSelectSuggestion(league: league)
      
    case let .setSearchQuery(query):
      self.updateSearchList(query: query)
    }
  }
  
}
