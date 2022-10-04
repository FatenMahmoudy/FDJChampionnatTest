//
//  NetworkingTests.swift
//  FDJChampionnatTestTests
//
//  Created by Faten Mahmoudi on 05/10/2022.
//

import XCTest
import Combine
@testable import FDJChampionnatTest

final class NetworkingTests: XCTestCase {
  
  var expectation: XCTestExpectation!
  var leaguesResponse: LeaguesSearchResponse?
  var teamsResponse: TeamsSearchResponse?
  
  var networking: Networking!
  var error: Error?
  
  var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    self.networking = Networking()
    self.cancellables = []
  }
  
  override func tearDownWithError() throws {
    self.networking = nil
    self.cancellables = nil
    self.error = nil
  }
  
  func testGetAllLeagues() {
    
    var leagues: [League] = []
    let expectation = self.expectation(description: "Get All Leagues")
    
    self.networking.get(type: LeaguesSearchResponse.self, endpoint: .getAllLeaguesList)
      .sink { complete in
        switch complete {
        case let .failure(error):
          self.error = error
        case .finished:
          break
        }
        expectation.fulfill()
      } receiveValue: { value in
        self.leaguesResponse = value
        leagues = value.leagues ?? []
      }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    XCTAssertNil(error)
    XCTAssertNotNil(self.leaguesResponse)
    XCTAssertEqual(leagues.count, 935)
    XCTAssertEqual(leagues[0].id, "4328")
    XCTAssertEqual(leagues[0].name, "English Premier League")
    
  }
  
  func testGetTeams() {
    
    var teams: [Team] = []
    let expectation = self.expectation(description: "Get League's Team")
    let leagueName = "French ligue 1"
    
    self.networking.get(type: TeamsSearchResponse.self, endpoint: AppAPI.getLeagueTeamsList(leagueName: leagueName))
      .sink { complete in
        switch complete {
        case let .failure(error):
          self.error = error
        case .finished:
          break
        }
        expectation.fulfill()
      } receiveValue: { value in
        self.teamsResponse = value
        teams = self.teamsResponse?.teams ?? []
      }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    XCTAssertNil(error)
    XCTAssertNotNil(self.teamsResponse)
    XCTAssertEqual(teams.count, 20)
    XCTAssertEqual(teams[0].id, "133702")
    XCTAssertEqual(teams[0].name, "Ajaccio")
    XCTAssertEqual(teams[0].championship, "French Ligue 1")
  }
  
  func testGetTeamDetails() {
    
    var team: Team?
    let expectation = self.expectation(description: "Get League's Team")
    let teamName = "paris sg"
    
    self.networking.get(type: TeamsSearchResponse.self, endpoint: AppAPI.getTeamDetails(teamName: teamName))
      .sink { complete in
        switch complete {
        case let .failure(error):
          self.error = error
        case .finished:
          break
        }
        expectation.fulfill()
      } receiveValue: { value in
        team = value.teams?.first
      }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    XCTAssertNotNil(team)
    XCTAssertEqual(team?.id, "133714")
    XCTAssertEqual(team?.name, "Paris SG")
    XCTAssertEqual(team?.championship, "French Ligue 1")
  }
  
}
