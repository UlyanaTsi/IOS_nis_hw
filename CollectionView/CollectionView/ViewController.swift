//
//  ViewController.swift
//  CollectionView
//
//  Created by Ульяна Цимбалистая on 30.10.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    let cellId = "Cell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCell
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 3)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        // иначе функции collectionView не будут вызываться
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.black
        self.view.addSubview(collectionView)
    }
}

