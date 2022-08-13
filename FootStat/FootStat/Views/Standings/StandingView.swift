//
//  StandingView.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 09.08.2022.
//

import SwiftUI

struct StandingView: View {
    
    @EnvironmentObject var footballViewModel: FootballViewModel
    @State var season: Season
    let league: League
    
    private let statColumnKeys = ["GP", "W", "D", "L", "P"]
    
    var body: some View {
        VStack {
            standingHeader
            if let unwrappedStanding = season.standings {
                ScrollView {
                    VStack {
                        ForEach(unwrappedStanding, id: \.team.id) { standing in
                            StandingRowView(standing: standing)
                        }
                    }
                    .padding(.bottom)
                }
            } else {
                LoadingView()
                    .padding(.top, 100)
            }
            Spacer()
        }
        .navigationBarTitle(Text("\(league.abbr) \(season.year.description)"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ChangeSeasonButton(league: league, season: $season)
            }
        }
        .onAppear {
            Task {
                try await footballViewModel.loadStandings(forLeague: league.id, year: season.year)
            }
        }
    }
    
    mutating func changeSeason(for season: Season) {
        self.season = season
    }
}

extension StandingView {
    private var standingHeader: some View {
        HStack {
            Text("#")
                .frame(width: 25)
                .background()
            Spacer(minLength: 4)
            Text("Team")
            Spacer(minLength: 4)
            HStack(spacing: 0) {
                ForEach(statColumnKeys, id: \.self) { statKey in
                    Text(statKey)
                        .frame(width: 25)
                }
            }
        }
        .padding(.horizontal)
        .font(.callout)
    }
}

struct ChangeSeasonButton: View {
    
    @EnvironmentObject var footballViewModel: FootballViewModel
    let league: League
    @Binding var season: Season
    
    var body: some View {
        Menu {
            if let unwrappedSeasons = league.seasons {
                ForEach(unwrappedSeasons, id: \.year) { season in
                    Button(season.displayName) {
                        self.season = season
                    }
                }
            }
        } label: {
            Image(systemName: "calendar")
        }
    }
    
    private func doSomething() {
        print("Runned out of time...")
    }
}
