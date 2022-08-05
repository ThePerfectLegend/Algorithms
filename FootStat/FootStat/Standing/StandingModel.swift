//
//  StandingModel.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import Foundation

struct StandingModel: Codable {
    let status: Bool
    let data: SeasonData
    
    struct SeasonData: Codable {
        let abbreviation: String?
        let name, seasonDisplay: String
        let season: Int
        let standings: [Standing]
        
        struct Standing: Codable, Identifiable {
            let id = UUID()
            let team: Team
            let note: Note?
            let stats: [Stat]
            
            struct Team: Codable {
                let id, name: String
                let abbreviation: String?
                let displayName: String
                let shortDisplayName: String
                let logos: [Logo]?
                
                struct Logo: Codable {
                    let href: String
                    let width, height: Int
                    let alt: String
                }
            }
            
            struct Note: Codable {
                let color, description: String
                let rank: Int
            }
            
            struct Stat: Codable, Identifiable {
                let id = UUID()
                let name: String
                let displayName: String
                let displayValue: String
            }
        }
    }
}
