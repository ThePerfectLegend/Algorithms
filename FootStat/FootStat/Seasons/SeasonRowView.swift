//
//  SeasonRowView.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import SwiftUI

struct SeasonRowView: View {
    
    let season: SeasonModel.LeagueData.Season
    private let showStages: Bool
    private let startDate: Date
    private let endDate: Date
    
    init(_ season: SeasonModel.LeagueData.Season) {
        self.season = season
        self.startDate = Date(stringDate: season.startDate)
        self.endDate = Date(stringDate: season.endDate)
        
        if season.types.count > 1 {
            self.showStages = true
        } else {
            self.showStages = false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(season.displayName)
                .font(.headline)
            Group {
                Text("Starts: \(startDate.asShortDateString())")
                Text("Ends: \(endDate.asShortDateString())")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            stageView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension SeasonRowView {
    @ViewBuilder var stageView: some View {
        if showStages {
            VStack(alignment: .leading) {
                Text("Stages:")
                    .font(.headline)
                ForEach(season.types, id: \.self) { stage in
                    Text(stage.name)
                        .font(.subheadline)
                }
            }
        }
    }
}
