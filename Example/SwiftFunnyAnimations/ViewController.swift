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
    
    var  allShapesAnimation : FunnyAnimations!
    var  trianglesAnimation : FunnyAnimations!
    var  circlesAnimation : FunnyAnimations!
    var  squaresAnimation : FunnyAnimations!
    var  bitmapsAnimation : FunnyAnimations!
    
    
    
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
        
       
        
        self.allShapesAnimation = FunnyAnimations(rootview: self.view)
        self.trianglesAnimation = FunnyAnimations(rootview: self.view)
        self.circlesAnimation = FunnyAnimations(rootview: self.view)
        self.bitmapsAnimation = FunnyAnimations(rootview: self.view)
        self.squaresAnimation = FunnyAnimations(rootview: self.view)
        
        self.allShapesAnimation.appendParticles(from:
            [.circle,.triangle,.square], size: 30, colors: [color1,color2,color5,color6])
        
        self.trianglesAnimation.appendParticles(from: [.triangle], size: 30, colors: [color1,color2,color3])
        
        self.circlesAnimation.appendParticles(from: [.circle], size: 30, colors: [color5,color6,color7])
        
        self.squaresAnimation.appendParticles(from: [.square], size: 30, colors: [color1,color2,color3])
        
        self.bitmapsAnimation.appendParticles(from: [heartIcon,likeIcon])
        
        //self.view.backgroundColor = UIColor(red: 1, green: 55 / 255, blue: 93 / 255, alpha: 1)
         self.view.backgroundColor = UIColor(red: 53 / 255, green: 71 / 255, blue: 125 / 255, alpha: 1)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    

    
    @IBAction func wabeToDownAllShapes(_ sender : UIView){
        self.allShapesAnimation.startWave(from: sender, total: 20, direction: .toDown, sizeVariation: 0.5, randomRotation: true)
    }
    
    @IBAction func wabeToRightTriangles(_ sender : UIView){
        self.trianglesAnimation.startWave(from: sender, total: 20, direction: .toRight, sizeVariation: 0.5, randomRotation: true)
    }
    
    @IBAction func wabeToLeftCircles(_ sender : UIView){
        self.circlesAnimation.startWave(from: sender, total: 20, direction: .toLeft, sizeVariation: 0.5, randomRotation: true)
    }
    
    @IBAction func wabeToTopBitmaps(_ sender : UIView){
        self.bitmapsAnimation.startWave(from: sender, total: 20, direction: .toTop, sizeVariation: 0.5, randomRotation: false)
    }
    
    @IBAction func rainToDownAllShapes(_ sender:Any){
        self.allShapesAnimation.startWaveRain(total: 30, direction: .toDown, sizeVariation: 0.5, randomRotation: true)
    }
    
    @IBAction func rainToLeftCirclesShapes(_ sender:Any){
        self.circlesAnimation.startWaveRain(total: 30, direction: .toLeft, sizeVariation: 0.5, randomRotation: true)
    }
    
    @IBAction func rainToRightSquaresShapes(_ sender:Any){
        self.squaresAnimation.startWaveRain(total: 30, direction: .toRight, sizeVariation: 0.5, randomRotation: true)
    }
    
    @IBAction func rainToTopBitmaps(_ sender:Any){
        self.bitmapsAnimation.startWaveRain(total: 20, direction: .toTop, sizeVariation: 0.3, randomRotation: false)
    }
    
    @IBAction func rainAllDirections(_ sender:Any){
        self.allShapesAnimation.startWaveRain(total: 10, direction: .toDown, sizeVariation: 0.5, randomRotation: true)
        self.allShapesAnimation.startWaveRain(total: 10, direction: .toTop, sizeVariation: 0.5, randomRotation: true)
        self.allShapesAnimation.startWaveRain(total: 10, direction: .toLeft, sizeVariation: 0.5, randomRotation: true)
        self.allShapesAnimation.startWaveRain(total: 10, direction: .toRight, sizeVariation: 0.5, randomRotation: true)
    }
    
    

}

