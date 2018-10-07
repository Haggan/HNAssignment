//
//  DetailViewController.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-07.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var ad: BasicAd!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    /**
     Functions as a kind of init, so we can inject variables into a UIViewController instantiated from
     a storyboard
     */
    class func instantiate(with ad: BasicAd) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: DetailViewController.self))
        
        guard let viewController
            = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
                as? DetailViewController else { fatalError("Wrong viewController") }
        
        viewController.ad = ad
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ad.title
    }
}
