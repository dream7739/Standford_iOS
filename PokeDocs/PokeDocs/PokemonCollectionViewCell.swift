//
//  PokemonCollectionViewCell.swift
//  PokeDocs
//
//  Created by 홍정민 on 2024/04/29.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let cellID = "PokeCollectionViewCell"
    
    var pokemonInfo: PokemonDetailInfo? {
        didSet {
            guard let pokemonInfo = pokemonInfo else { return }
            self.nameLabel.text = pokemonInfo.name
            guard let img = pokemonInfo.sprites?.front_default else { return }
            guard let imgURL = NSURL(string: img) else { return }
            self.imageView.loadImage(from: imgURL as URL)
        }
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.tertiarySystemBackground
        iv.contentMode = .scaleAspectFit //비율 유지, 남는 부분 투명 처리
        return iv
    }()
    
    lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow100
        return view
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    //뷰를 코드에서 만들 시 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }
    
    //스토리보드에서 뷰를 만들 시 호출
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureViewComponents(){
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true //전체 뷰를 초과하지 않도록
        
        //코드로 오토레이아웃 설정하도록 해당 옵션을 false
        //슈퍼뷰의 bounds가 변경될 때 autoResizing 기능
        //스토리보드에서는 오토레이아웃 적용된 뷰에 자동으로 false를 적용해주지만 코드에서는 직접 꺼주어야 함
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        self.addSubview(textView)
        textView.addSubview(nameLabel)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: textView.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor).isActive = true
        
        
        
    }
}
