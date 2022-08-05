//
//  SeasonsModel.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import Foundation

struct SeasonModel: Codable {
    let status: Bool
    let data: LeagueData
    
    struct LeagueData: Codable {
        let name: String?
        let desc: String
        let abbreviation: String?
        let seasons: [Season]
        
        struct Season: Codable, Hashable {
            let year: Int
            let startDate, endDate, displayName: String
            let types: [Competitions]
            
            struct Competitions: Codable, Hashable {
                let id, name, abbreviation, startDate: String
                let endDate: String
                let hasStandings: Bool
            }
        }
    }
}

