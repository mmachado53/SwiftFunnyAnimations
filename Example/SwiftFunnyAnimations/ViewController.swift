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
    var funnyAnimation2:FunnyAnimations!
    let heartIcon:UIImage = UIImage(named: "heart_icon")!
    let likeIcon:UIImage = UIImage(named: "like_icon")!
    let color1:UIColor = UIColor(red: 1 / 255, green: 131 / 255, blue: 131 / 255, alpha: 1)
    let color2:UIColor = UIColor(red: 2 / 255, green: 168 / 255, blue: 168 / 255, alpha: 1)
    let color3:UIColor = UIColor(red: 66 / 255, green: 230 / 255, blue: 164 / 255, alpha: 1)
    let color4:UIColor = UIColor(red: 245 / 255, green: 222 / 255, blue: 163 / 255, alpha: 1)
    
    
    
    let color5:UIColor = UIColor(red: 246 / 255, green: 114 / 255, blue: 128 / 255, alpha: 1)
    let color6:UIColor = UIColor(red: 192 / 255, green: 108 / 255, blue: 132 / 255, alpha: 1)
    let color7:UIColor = UIColor(red: 108 / 255, green: 91 / 255, blue: 123 / 255, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(red: 1, green: 55 / 255, blue: 93 / 255, alpha: 1)
         self.view.backgroundColor = UIColor(red: 53 / 255, green: 71 / 255, blue: 125 / 255, alpha: 1)
        self.funnyAnimation = FunnyAnimations(rootview: self.view)
        self.funnyAnimation2 = FunnyAnimations(rootview: self.view)
        let shapes:[FunnyAnimations.Shape] = [.circle,.square,.triangle]
        let colors:[UIColor] = [UIColor.red,UIColor.green,UIColor.blue]
        self.funnyAnimation2.appendParticles(from: shapes, size: 20, colors: [
            color5,
            color6,
            color7
            ])
        self.funnyAnimation.appendParticles(from: [likeIcon,heartIcon])
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressButtonAction(_ sender : UIButton){
        //self.funnyAnimation.startWaveRain(total: 5, direction: .leftToRight, sizeVariation: 0.5)
        //self.funnyAnimation.startWaveRain(total: 5, direction: .rightToLeft, sizeVariation: 0.5)
        self.funnyAnimation2.startWaveRain(total: 50, direction: .topToDown, sizeVariation: 0.5, randomRotation: true)
        //self.funnyAnimation.startWaveRain(total: 5, direction: .downToTop, sizeVariation: 0.5)
        self.funnyAnimation.startWave(from: sender, total: 20, direction: .downToTop, sizeVariation: 0.5, randomRotation: false)
    }
    
    

}

