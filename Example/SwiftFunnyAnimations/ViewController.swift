//
//  ViewController.swift
//  SwiftFunnyAnimations
//
//  Created by mmachado53 on 12/11/2019.
//  Copyright (c) 2019 mmachado53. All rights reserved.
//

import UIKit
import SwiftFunnyAnimations
class ViewController: UIViewController {
    
    var funnyAnimation:FunnyAnimations!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.funnyAnimation = FunnyAnimations(rootview: self.view)
        funnyAnimation.appendParticles(from: [FunnyAnimations.Shape.circle,FunnyAnimations.Shape.triangle,.square], size: 20, colors: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressButtonAction(_ sender : UIButton){
        funnyAnimation.startWaveRain(total: 10, direction: .topToDown, sizeVariation: 0.5)
    }
    
    

}

