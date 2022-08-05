//
//  LeaguesView.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import SwiftUI

struct LeaguesView: View {
    
    @ObservedObject var leaguesPresenter = LeaguesPresenter()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(leaguesPresenter.leagues) { league in
                    NavigationLink(destination: SeasonsView(leagueId: league.id)) {
                        LeagueRowView(league: league)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Leagues"), displayMode: .large)
        }
    }
}
