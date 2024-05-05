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
            
            //포켓몬 이름
            self.nameLabel.text = pokemonInfo.name
            
            //포켓몬 이미지
            guard let img = pokemonInfo.sprites?.front_default else { return }
            guard let imgURL = NSURL(string: img) else { return }
            self.imageView.loadImage(from: imgURL as URL)
            
            //포켓몬 타입
            guard let type = pokemonInfo.types?.first?.type?.name else { return }
            self.typeLabel.text = type
        }
    }
    
    lazy var backDecoView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.tertiarySystemBackground
        iv.contentMode = .scaleAspectFit //비율 유지, 남는 부분 투명 처리
        return iv
    }()
    
    lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayScale900
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.grayScale800
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
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
        self.backgroundColor = UIColor.grayScale800
        
        //코드로 오토레이아웃 설정하도록 해당 옵션을 false
        //슈퍼뷰의 bounds가 변경될 때 autoResizing 기능
        //스토리보드에서는 오토레이아웃 적용된 뷰에 자동으로 false를 적용해주지만 코드에서는 직접 꺼주어야 함
        backDecoView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backDecoView)
        backDecoView.layer.cornerRadius = 10
        backDecoView.layer.masksToBounds = true
        
        backDecoView.addSubview(imageView)
        backDecoView.addSubview(textView)
        textView.addSubview(nameLabel)
        textView.addSubview(typeLabel)
        
        backDecoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        backDecoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        backDecoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        backDecoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        imageView.topAnchor.constraint(equalTo: backDecoView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: backDecoView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: backDecoView.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: backDecoView.heightAnchor, multiplier: 0.6).isActive = true

        textView.leftAnchor.constraint(equalTo: backDecoView.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: backDecoView.rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: backDecoView.bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: backDecoView.heightAnchor, multiplier: 0.4).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: textView.leftAnchor,constant: 15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 15).isActive = true
        
        typeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5).isActive = true
        
    }
}
