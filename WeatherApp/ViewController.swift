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
    
    private var dynamicAnimator: UIDynamicAnimator!
    
    private var gravity: UIGravityBehavior!
    
    private var collision: UICollisionBehavior!
    
    // This ViewController is the very
    // first the user sees when the app
    // is started. The UILabel uses
    // UIDynamics.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Makes the UILabel fall downwards, as if
    // affected by gravity. It is given collision
    // detection, to prevent it from falling out of
    // the screen.
    func dynamics() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [appTitle])
        
        collision = UICollisionBehavior(items: [appTitle])
        
        collision.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(collision)
        
        dynamicAnimator.addBehavior(gravity)
    }

}

