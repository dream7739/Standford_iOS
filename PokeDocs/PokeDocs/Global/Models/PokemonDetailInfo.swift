//
//  PokemonDetailInfo.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/30.
//

import Foundation

struct PokemonDetailInfo: Decodable {
    let id: Int
    let name: String?
    let height: Int?
    let sprites: PokemonSprites?
}
