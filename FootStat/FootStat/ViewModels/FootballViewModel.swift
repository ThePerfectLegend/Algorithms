//
//  FootballViewModel.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 07.08.2022.
//

import Foundation

@MainActor class FootballViewModel: ObservableObject {
    
    @Published var leagues: [League] = []
    private let networkManager = NetworkManager.instance
    
    init() {
        Task {
            try await loadLeagues()
        }
    }
    
    private func loadLeagues() async throws {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues") else {
            throw URLError(.badURL)
        }
        guard let leaguesData = try? await networkManager.download(url: url) else {
            print("Bad responce")
            throw URLError(.badServerResponse)
        }
        guard let leagues = try? JSONDecoder().decode(LeagueResponse.self, from: leaguesData) else {
            print("Wrong parsing")
            throw URLError(.cannotParseResponse)
        }
        self.leagues = leagues.leagues
    }
        
    func loadSeasons(forLeague id: String) async throws {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues/\(id)/seasons") else {
            throw URLError(.badURL)
        }
        guard let seasonData = try? await networkManager.download(url: url) else {
            print("Error: getting data")
            throw URLError(.badServerResponse)
        }
        guard let seasons = try? JSONDecoder().decode(SeasonResponse.self, from: seasonData) else {
            print("Error: decoding data")
            throw URLError(.cannotDecodeContentData)
        }
        
        guard let responsedLeagueIndex = try? leagues.firstIndex(where: { $0.id == id }) else {
            print("Error: find match element")
            throw URLError(.cannotCreateFile)
        }
        
        leagues[responsedLeagueIndex].responseStatus = seasons.status
        
        if let unwrappedSeasons = seasons.data?.seasons {
            leagues[responsedLeagueIndex].seasons = unwrappedSeasons
        }
    }
    
    func loadStandings(forLeague id: String, year: Int) async throws {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues/\(id)/standings?season=\(String(year))&sort=asc") else {
            throw URLError(.badURL)
        }
        
        guard let standingsData = try? await networkManager.download(url: url) else {
            print("Error: getting standings data")
            print(url)
            throw URLError(.badServerResponse)
        }
        
        guard let standings = try? JSONDecoder().decode(StandingResponse.self, from: standingsData) else {
            print("Error: decoding standings data")
            throw URLError(.cannotDecodeContentData)
        }
        
        guard let responsedLeagueIndex = try? leagues.firstIndex(where: { $0.id == id }) else {
            print("Error: find season element")
            throw URLError(.cannotCreateFile)
        }
        
        guard let responsedYearIndex = try? leagues[responsedLeagueIndex].seasons?.firstIndex(where: { $0.year == year }) else {
            print("Error: find year element")
            throw URLError(.cannotCreateFile)
        }
        
        leagues[responsedLeagueIndex].seasons![responsedYearIndex].responseStatus = standings.status
        
        if let unwrappedStanding = standings.data?.standings {
            leagues[responsedLeagueIndex].seasons![responsedYearIndex].standings = unwrappedStanding
            print(unwrappedStanding)
        }
        
        
    }
}
