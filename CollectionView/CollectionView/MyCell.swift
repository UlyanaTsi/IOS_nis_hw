//
//  MyCell.swift
//  CollectionView
//
//  Created by Ульяна Цимбалистая on 30.10.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//
import UIKit

class MyCell: UICollectionViewCell {
    
    let profileImageButton: UIButton = {
        let control = UIButton()
        control.backgroundColor = UIColor.init(red: 0.3, green: 0, blue: 0.3, alpha: 0.3)//цвет
        control.layer.cornerRadius = 5 // скругдение углов
        control.clipsToBounds = false // изменить их цвет?
        control.setImage(UIImage(named: "Profile"), for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
    
    let dateLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 12, weight: .light)
        control.textAlignment = .center
        control.textColor = UIColor.black
        
        control.text = "25"
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let dayLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 12, weight: .light)
        control.textAlignment = .center
        control.textColor = UIColor.black
        control.text = "Tue"
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
//    
//    let distanceLabel: UILabel = {
//        let control = UILabel()
//        control.font = UIFont.systemFont(ofSize: 10, weight: .light)
//        control.textColor = UIColor.lightGray
//        control.text = "What's up?"
//        control.translatesAutoresizingMaskIntoConstraints = false
//        
//        return control
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        backgroundColor = UIColor.white
        
        addSubview(profileImageButton)
        addSubview(dateLabel)
        addSubview(dayLabel)
        
        profileImageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        profileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        profileImageButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        dateLabel.centerYAnchor.constraint(equalTo: profileImageButton.centerYAnchor, constant: -6).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: profileImageButton.centerXAnchor).isActive = true
        
        dayLabel.centerYAnchor.constraint(equalTo: profileImageButton.centerYAnchor, constant: 9).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: profileImageButton.centerXAnchor).isActive = true
        
    }
}
