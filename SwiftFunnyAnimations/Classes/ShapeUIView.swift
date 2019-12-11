//
//  ShapeUIView.swift
//  Pods-SwiftFunnyAnimations_Example
//
//  Created by Miguel Machado on 12/11/19.
//

import UIKit

public class ShapeUIView:UIView{
    @IBInspectable public var shapeColor:UIColor = UIColor.red {
        didSet{
            self.draw(self.frame)
        }
    }
}
