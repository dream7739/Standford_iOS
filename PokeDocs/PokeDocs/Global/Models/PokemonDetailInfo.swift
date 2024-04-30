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
    let sprites: PokemonSprites? // 사진
    let types: [PokemonTypes]? // 속성(불, 물... ETC)
}
