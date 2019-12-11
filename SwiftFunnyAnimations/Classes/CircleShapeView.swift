//
//  CircleShapeView.swift
//  Pods-SwiftFunnyAnimations_Example
//
//  Created by Miguel Machado on 12/11/19.
//

import UIKit

public class CircleShapeView:ShapeUIView{
    public override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {return}
        ctx.setFillColor(self.shapeColor.cgColor)
        ctx.fillEllipse(in: rect)
    }
}
