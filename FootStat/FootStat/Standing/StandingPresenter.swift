//
//  StandingPresenter.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import Foundation

class StandingPresenter: ObservableObject {
    
    @Published var statistic: StandingModel?
    private let networkManager = NetworkManager.instance
    let leagueId: String
    let seasonYear: Int
    
    init(leagueId: String, seasonYear: Int) {
        self.leagueId = leagueId
        self.seasonYear = seasonYear
        Task {
            try await loadStats()
        }
    }
    
    private func loadStats() async throws {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues/\(self.leagueId)/standings?season=\(String(seasonYear))&sort=asc") else {
            throw URLError(.badURL)
        }
        guard let statData = try? await networkManager.download(url: url) else {
            throw URLError(.badServerResponse)
        }
        guard let stats = try? JSONDecoder().decode(StandingModel.self, from: statData) else {
            print("\(statData) cannot parsed")
            throw URLError(.cannotParseResponse)
        }
        await MainActor.run {
            self.statistic = stats
        }
    }
}
