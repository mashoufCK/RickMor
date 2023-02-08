//
//  RMEpisode.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/5/23.
//

import Foundation

struct RMEpisodes: Codable {
    let id: String
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
