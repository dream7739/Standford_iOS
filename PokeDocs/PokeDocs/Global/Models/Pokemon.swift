//
//  Pokemon.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/30.
//

import Foundation

struct Pokemon: Decodable {
    let count: Int
    let next: String?
    let previous: Int?
    let results: [PokemonBaseInfo]?
}
