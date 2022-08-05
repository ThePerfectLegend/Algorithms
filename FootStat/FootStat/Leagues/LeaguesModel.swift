//
//  LeaguesModel.swift
//  FootStat
//
//  Created by Nizami Tagiyev on 04.08.2022.
//

import Foundation

struct LeagueModel: Codable {
    let status: Bool
    let data: [League]
    
    struct League: Identifiable, Codable {
        let id, name, slug, abbr: String
        let logos: Logos
        
        struct Logos: Codable {
            let light: String
            let dark: String
        }
    }
}




