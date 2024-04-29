//
//  ViewController.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/29.
//

import UIKit

class PokeViewControler: UICollectionViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
    }

    private func configureViewComponents(){
        self.title = "홍켓몬"
        collectionView.register(PokeCollectionViewCell.self, forCellWithReuseIdentifier: PokeCollectionViewCell.cellID)
        
        //네비게이션 바 설정
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.yellow300
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

//섹션 개수, 로우 개수, 리턴할 셀을 설정
extension PokeViewControler {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.cellID, for: indexPath) as! PokeCollectionViewCell
        return cell
    }
}

//셀 사이즈 설정
extension PokeViewControler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 8, right: 8)
    }
}
