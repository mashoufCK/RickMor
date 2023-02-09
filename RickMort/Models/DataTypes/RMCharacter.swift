//
//  RMCharacter.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 2/5/23.
//

import Foundation

struct RMCharater: Codable {
    let id: Int
    let name: String
    let status:  RMCharaterStatus
    let species:  String
    let type: String
    let gender: RMCharaterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
 

