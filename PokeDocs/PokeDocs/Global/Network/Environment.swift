//
//  Environment.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/30.
//

import Foundation

struct Environment {
    static func url(_ path: String) -> String {
        return "https://pokeapi.co/api/v2" + path
    }
}
