//
//  PokemonBaseInfo.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/30.
//

import Foundation

struct PokemonBaseInfo: Decodable {
    var url: String?
    var detail: PokemonDetailInfo?
}
