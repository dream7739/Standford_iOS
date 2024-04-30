//
//  PokemonService.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/30.
//

import Foundation

class PokemonService {
    
    func fetchPokemons() async throws -> Pokemon {
        if let url = URL(string: Environment.url("/pokemon")) {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      throw PokemonServiceError.invalideServiceResponse
                  }
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return pokemon
        }else{
            throw PokemonServiceError.unsupportedURL
        }
    }
    
    func fetchDetail(url: String) async throws -> PokemonDetailInfo {
        if let url = URL(string: url){
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      throw PokemonServiceError.invalideServiceResponse
                  }
            let pokemonDetail = try JSONDecoder().decode(PokemonDetailInfo.self, from: data)
            return pokemonDetail
        }else{
            throw PokemonServiceError.unsupportedURL
        }
    }
}
