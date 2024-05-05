//
//  PokemonViewControler.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/29.
//

import UIKit

class PokemonViewControler: UICollectionViewController {
    private let pokemonService = PokemonService()
    
    private var pokemons: Pokemon?
    
    private var pokemonDetail = [PokemonDetailInfo]()
    
    override func viewWillAppear(_ animated: Bool) {
        Task{
            await getPokemons()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    }
    
    
    private func getPokemons() async {
        do{
            let entirePokemons = try await pokemonService.fetchPokemons()
            pokemons = entirePokemons
            await getPokemonDetail()
        }catch PokemonServiceError.invalideServiceResponse {
            print("pokedocs Error - invalide service response")
        }catch PokemonServiceError.unsupportedURL {
            print("pokemon Error - unsupported url")
        }catch {
            print("error accured")
        }
        
    }
    
    private func getPokemonDetail() async {
        do{
            try await withThrowingTaskGroup(of: PokemonDetailInfo.self){ taskGroup in
                guard let result = pokemons?.results else { return }
                result.enumerated().forEach { (index, model) in
                    taskGroup.addTask {
                        let itemDetail = try await self.pokemonService.fetchDetail(url: model.url!)
                        return itemDetail
                    }
                }
                
                for try await result in taskGroup {
                    pokemonDetail.append(result)
                }
                
                print("\(pokemonDetail)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }catch {
            print("Error loading Pokemon details: \(error.localizedDescription)")
        }
    }
    
    
    private func configureViewComponents(){
        self.title = "홍켓몬GO"
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.cellID)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
}

//섹션 개수, 로우 개수, 리턴할 셀을 설정
extension PokemonViewControler {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonDetail.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.cellID, for: indexPath) as! PokemonCollectionViewCell
        cell.pokemonInfo = pokemonDetail[indexPath.row]
        return cell
    }
}

//셀 사이즈 설정
extension PokemonViewControler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        let height = (collectionView.frame.height - 30) / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
