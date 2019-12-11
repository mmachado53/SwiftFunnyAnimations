//
//  TriangleShapeView.swift
//  Pods-SwiftFunnyAnimations_Example
//
//  Created by Miguel Machado on 12/11/19.
//

import UIKit

public class TriangleShapeView:ShapeUIView{
    public override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {return}

        ctx.beginPath()
        ctx.move(to: CGPoint(x: rect.width / 2, y: 0))
        ctx.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        ctx.addLine(to: CGPoint(x: 0, y: rect.maxY))
        ctx.closePath()
        ctx.setFillColor(self.shapeColor.cgColor)
        ctx.fillPath()
    }
}
