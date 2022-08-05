//
//  SeasonsView.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import SwiftUI

struct SeasonsView: View {
    
    @ObservedObject var seasonPresenter: SeasonPresenter
    
    init(leagueId: String) {
        self.seasonPresenter = SeasonPresenter(leagueId: leagueId)
    }
    
    var body: some View {
        if let unwrappedSeasons = seasonPresenter.seasons {
            List {
                ForEach(unwrappedSeasons.data.seasons, id: \.self) { season in
                    NavigationLink(destination: StandingView(leagueId: seasonPresenter.leagueId, seasonYear: season.year)) {
                        SeasonRowView(season)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text(unwrappedSeasons.data.name ?? "Football League"), displayMode: .inline)
            .environmentObject(seasonPresenter)
        }
    }
}


