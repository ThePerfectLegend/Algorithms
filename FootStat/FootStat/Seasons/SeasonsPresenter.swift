//
//  SeasonsPresenter.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import Foundation

class SeasonPresenter: ObservableObject {
    
    @Published var seasons: SeasonModel?
    private let networkManager = NetworkManager.instance
    let leagueId: String
    
    init(leagueId: String) {
        self.leagueId = leagueId
        Task {
            try await loadSeasons()
        }
    }
    
    private func loadSeasons() async throws  {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues/\(self.leagueId)/seasons") else {
            throw URLError(.badURL)
        }
        guard let seasonData = try? await networkManager.download(url: url) else {
            throw URLError(.badServerResponse)
        }
        guard let seasons = try? JSONDecoder().decode(SeasonModel.self, from: seasonData) else {
            throw URLError(.cannotParseResponse)
        }
        await MainActor.run {
            self.seasons = seasons
        }
    }
}
