//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eric Groseclos on 2018-03-03.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    
    var dynamicAnimator: UIDynamicAnimator!
    
    var gravity: UIGravityBehavior!
    
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dynamics() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [appTitle])
        
        collision = UICollisionBehavior(items: [appTitle])
        
        collision.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(collision)
        
        dynamicAnimator.addBehavior(gravity)
    }

}

