//
//  AutocompleteProtocolMock.swift
//  FDJChampionnatTestTests
//
//  Created by Faten Mahmoudi on 05/10/2022.
//

import Foundation
@testable import FDJChampionnatTest

final class AutocompleteProtocolMock: AutocompleteProtocol {
  
  var league: League?
  
  func didSelectSuggestion(league: FDJChampionnatTest.League) {
    self.league = league
  }
}
