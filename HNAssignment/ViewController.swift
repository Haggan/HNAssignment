//
//  ViewController.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: ContentDataSource? {
        didSet {
            collectionView.dataSource = dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiService = HNMockApiService()
        let listService = HNListService(apiService: apiService)
        let imageService = HNImageService(urlSession: URLSession.shared) // URLSession.shared for convenience atm
        let imageCache = HNImageCache(imageService: imageService)
        
        self.dataSource = CollectionViewListDataSource(listService: listService,
                                                       collectionView: collectionView,
                                                       imageCache: imageCache)
        
        collectionView.collectionViewLayout = collectionViewLayout
        dataSource?.restart()
    }
}

extension ViewController {
    var collectionViewLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 112)
        
        return layout
    }
}

