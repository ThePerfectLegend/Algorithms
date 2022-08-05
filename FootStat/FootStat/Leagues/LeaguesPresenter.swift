//
//  LeaguesPresenter.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import Foundation

class LeaguesPresenter: ObservableObject {
    
    @Published var leagues: [LeagueModel.League] = []
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
            throw URLError(.badServerResponse)
        }
        guard let leagues = try? JSONDecoder().decode(LeagueModel.self, from: leaguesData) else {
            throw URLError(.cannotParseResponse)
        }
        await MainActor.run {
            self.leagues = leagues.data
        }
    }
}
