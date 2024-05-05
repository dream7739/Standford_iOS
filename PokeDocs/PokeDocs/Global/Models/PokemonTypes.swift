//
//  PokemonTypes.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/05/01.
//

import Foundation

struct PokemonTypes: Decodable {
    let type: PokemonTypesDetail?
}

struct PokemonTypesDetail: Decodable {
    let name: String?
    let url: String?
}
