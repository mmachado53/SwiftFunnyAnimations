//
//  FunnyAnimations.swift
//  Pods-SwiftFunnyAnimations_Example
//
//  Created by Miguel Machado on 12/11/19.
//

import UIKit


public class FunnyAnimations{
    
    
    public enum Shape{
        case square
        case circle
        case triangle
    }
    
    private var colors:[UIColor] = [
        UIColor.red,
        UIColor.blue
    ]
    private var shapes:[FunnyAnimations.Shape] = [
        .square,
        .circle,
        .triangle
    ]
    private var size:CGFloat = 10
    
    private var images:[UIImage]?
    private var imageViews:[UIImageView]?
    
    init(from images:[UIImage],tintColors:[UIColor] = []) {
        self.imageViews = []
        images.forEach({ (image) in
            if tintColors.count == 0 {
                self.imageViews?.append(UIImageView(image: image))
            }else{
                let imageForTintedViews:UIImage = image.withRenderingMode(.alwaysTemplate)
                tintColors.forEach { (tintColor) in
                    let tintedImageView:UIImageView = UIImageView(image: imageForTintedViews)
                    tintedImageView.tintColor = tintColor
                    self.imageViews?.append(tintedImageView)
                }
            }
            
        })
    }
    
    init(from shapes:[FunnyAnimations.Shape],size:CGFloat? = nil, colors:[UIColor]? = nil) {
        self.shapes = shapes
        self.colors = colors == nil ? self.colors : colors!
        self.size = size == nil ? self.size : size!
        self.generateParticles()
    }
    
    init(){
        self.generateParticles()
    }
    
    private func generateParticles(){
        
    }
}
