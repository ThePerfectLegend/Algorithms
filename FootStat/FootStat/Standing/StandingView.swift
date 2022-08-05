//
//  StandingView.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import SwiftUI

struct StandingView: View {
    
    @ObservedObject var standingPresentor: StandingPresenter
    private var seasons: SeasonPresenter
    private let statColumnKeys = ["GP", "W", "D", "L", "P"]
    
    init(leagueId: String, seasonYear: Int) {
        self.standingPresentor = StandingPresenter(leagueId: leagueId, seasonYear: seasonYear)
        self.seasons = SeasonPresenter(leagueId: leagueId)
    }
    
    var body: some View {
        VStack {
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
            if let unwrappedStanding = standingPresentor.statistic {
                ScrollView {
                    VStack {
                        ForEach(unwrappedStanding.data.standings) { standing in
                            StandingRowView(standing: standing)
                        }
                    }
                    .padding(.bottom)
                }
                .navigationBarTitle(Text("\(unwrappedStanding.data.abbreviation ?? "") \(unwrappedStanding.data.season.description)"), displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ChangeSeasonMenuButton(seasonPresenter: seasons)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChangeSeasonMenuButton: View {
    var seasonPresenter: SeasonPresenter
    
    var body: some View {
        if let unwrappedSeasons = seasonPresenter.seasons {
            Menu {
                ForEach(unwrappedSeasons.data.seasons, id: \.self) { season in
                    Button(season.displayName, action: doSomething)
                }
            } label: {
                Image(systemName: "calendar")
            }
        }
    }
    
    func doSomething() {
        print("Runned out of time...")
    }
}
