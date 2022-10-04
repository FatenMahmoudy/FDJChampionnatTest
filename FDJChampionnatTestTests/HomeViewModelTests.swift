//
//  HomeViewModelTests.swift
//  FDJChampionnatTestTests
//
//  Created by Faten Mahmoudi on 05/10/2022.
//

import XCTest
@testable import FDJChampionnatTest

final class HomeViewModelTests: XCTestCase {
    
  var dependenciesProvider = HomeViewDependenciesProviderMock()
  var viewModel: HomeViewModel!
//  var delegate = AutocompleteProtocolMock()
  
  override func setUpWithError() throws {
    self.viewModel = HomeViewModel(with: self.dependenciesProvider)
//    self.viewModel.autocompleteViewModel.configure(delegate: self.delegate)
  }
  
  override func tearDownWithError() throws {
    self.viewModel = nil
  }
  
  func testActions() throws {
    
    self.viewModel.handle(action: .launchGetAllLeaguesListRequest)
    XCTAssertTrue(self.viewModel.leagues.count == 4)
    
    self.viewModel.handle(action: .launchGetTeamsListRequest(leagueName: "yes yes a big cup or whatever"))
    XCTAssertTrue(self.viewModel.teamsVM.count == 1)
  }
  
//  func testAutocompleteAction () throws {
//  }
  
}
