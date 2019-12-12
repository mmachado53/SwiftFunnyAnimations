//
//  FunnyAnimations.swift
//  Pods-SwiftFunnyAnimations_Example
//
//  Created by Miguel Machado on 12/11/19.
//

import UIKit


public class FunnyAnimations{
    
    //private let window:UIWindow
    private let rootView:UIView
    
    public required init(rootview:UIView){
        self.rootView = rootview
    }
    
    public enum Direction{
        case topToDown
        case downToTop
        case leftToRight
        case rightToLeft
    }
    public enum Shape{
        case square
        case circle
        case triangle
    }
    
    private static let defaultColors:[UIColor] = [
        UIColor.red,
        UIColor.blue
    ]
    
    private static let defaultSize:CGFloat = 10
    
    private var particlesSprites : [UIImage] = []
    private var particlesSpritesTints : [UIColor?] = []
    //private var particlesViews : [UIView] = []
    //private var particlesViewsSizes : [CGSize] = []
    
    public var totalParticlesTypes:Int {
        get{
            return self.particlesSprites.count
        }
    }
    
    public func appendParticles(from shapes:[FunnyAnimations.Shape],size:CGFloat? = nil, colors:[UIColor]? = nil){
        
        let colors = colors == nil ? FunnyAnimations.defaultColors : colors!
        let size = size == nil ? FunnyAnimations.defaultSize : size!
        colors.forEach { (color) in
            if shapes.contains(.circle) {
                let circle:UIImage = buildCircleUIImage(size: size, color: color).withRenderingMode(.alwaysOriginal)
                self.particlesSprites.append(circle)
                self.particlesSpritesTints.append(color)
            }
            if shapes.contains(.triangle) {
                let triangle = buildTriangleUIImage(size: size, color: color).withRenderingMode(.alwaysOriginal)
                self.particlesSprites.append(triangle)
                self.particlesSpritesTints.append(color)
            }
            if shapes.contains(.square) {
                let square = buildSquareUIImage(size: size, color: color).withRenderingMode(.alwaysOriginal)
                self.particlesSprites.append(square)
                self.particlesSpritesTints.append(color)
            }
        }
        
    }
    
    public func appendParticles(from images:[UIImage],tintColors:[UIColor] = []){
        images.forEach({ (image) in
            if tintColors.count == 0 {
                self.particlesSprites.append(image)
                self.particlesSpritesTints.append(nil)
            }else{
                let imageForTintedViews:UIImage = image.withRenderingMode(.alwaysTemplate)
                tintColors.forEach { (tintColor) in
                    self.particlesSprites.append(imageForTintedViews)
                    self.particlesSpritesTints.append(tintColor)
                }
            }
            
        })
    }
    
    public func clearParticlesTypes(){
        self.particlesSpritesTints.removeAll()
        self.particlesSprites.removeAll()
    }
    
    
    public func startWaveRain(total:Int,direction:Direction,sizeVariation:CGFloat){
        if self.totalParticlesTypes <= 0 {return}
        for i in 1...total{
            let randomParticlesViewsIndex = Int( 0 + drand48() * Double(self.particlesSprites.count - 1))
            let sprite:UIImage = self.particlesSprites[randomParticlesViewsIndex]
            let imageView:UIImageView = UIImageView(image: sprite)
            imageView.tintColor = self.particlesSpritesTints[randomParticlesViewsIndex]
            //let initialViewSize:CGSize = self.particlesViewsSizes[randomParticlesViewsIndex]
            let size = randomScaleSize(for: imageView.frame.size, sizeVariation: sizeVariation)
            
    
            let animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
            
            imageView.frame = CGRect(x: -size.width, y: -size.height, width: size.width, height: size.height)
            
            let degrees = CGFloat(drand48() * 180)
            let radians = degrees / 180.0 * CGFloat.pi
            let rotation = imageView.transform.rotated(by: radians)
            imageView.transform = rotation
            
            let initialPoint:CGPoint = CGPoint(x: CGFloat(drand48()) * rootView.frame.width, y: -50)
            
            animation.delegate = AnimationDelegate(imageView)
            
            animation.path = FunnyAnimations.buildWaveAnimationPath(initialPoint: initialPoint, distance: rootView.frame.height + 100, direction: direction).cgPath
            animation.duration = 1 + drand48() * 2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = true
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            imageView.layer.add(animation, forKey: nil)
            self.rootView.addSubview(imageView)
        }
    }
    
    private static func buildLeftToRightAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .leftToRight)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5{
            cp1 = CGPoint(x: initialPoint.x + distance * 0.25, y: initialPoint.y + randomCurve)
            cp2 = CGPoint(x: initialPoint.x + distance * 0.50, y: initialPoint.y - randomCurve)
        }else{
            cp1 = CGPoint(x: initialPoint.x + distance * 0.25, y: initialPoint.y - randomCurve)
            cp2 = CGPoint(x: initialPoint.x + distance * 0.50, y: initialPoint.y + randomCurve)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildRightToLeftAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .rightToLeft)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5{
            cp1 = CGPoint(x: initialPoint.x - distance * 0.25, y: initialPoint.y + randomCurve)
            cp2 = CGPoint(x: initialPoint.x - distance * 0.50, y: initialPoint.y - randomCurve)
        }else{
            cp1 = CGPoint(x: initialPoint.x - distance * 0.25, y: initialPoint.y - randomCurve)
            cp2 = CGPoint(x: initialPoint.x - distance * 0.50, y: initialPoint.y + randomCurve)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildTopToDownAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .topToDown)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5{
            cp1 = CGPoint(x: initialPoint.x + randomCurve, y: initialPoint.y + distance * 0.25)
            cp2 = CGPoint(x: initialPoint.x - randomCurve, y: initialPoint.y + distance * 0.50)
        }else{
            cp1 = CGPoint(x: initialPoint.x - randomCurve, y: initialPoint.y + distance * 0.25)
            cp2 = CGPoint(x: initialPoint.x + randomCurve, y: initialPoint.y + distance * 0.50)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildDownToTopAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .downToTop)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5{
            cp1 = CGPoint(x: initialPoint.x + randomCurve, y: initialPoint.y - distance * 0.25)
            cp2 = CGPoint(x: initialPoint.x - randomCurve, y: initialPoint.y - distance * 0.50)
        }else{
            cp1 = CGPoint(x: initialPoint.x - randomCurve, y: initialPoint.y - distance * 0.25)
            cp2 = CGPoint(x: initialPoint.x + randomCurve, y: initialPoint.y - distance * 0.50)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildWaveAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat,
        direction:FunnyAnimations.Direction
        ) -> UIBezierPath {
        switch direction {
        case .downToTop:
            return buildDownToTopAnimationPath(initialPoint: initialPoint, distance: distance)
        case .leftToRight:
            return buildLeftToRightAnimationPath(initialPoint: initialPoint, distance: distance)
        case .rightToLeft:
            return buildRightToLeftAnimationPath(initialPoint: initialPoint, distance: distance)
        default:
            return buildTopToDownAnimationPath(initialPoint: initialPoint, distance: distance)
        }
    }


    
}

private class AnimationDelegate:NSObject,CAAnimationDelegate{
    var view:UIView
    init(_ view:UIView){
        self.view = view
    }
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == true {
            self.view.removeFromSuperview()
        }
    }
}


fileprivate func getEndPoint(from initialPoint:CGPoint,distance:CGFloat,direction:FunnyAnimations.Direction)->CGPoint{
    switch direction {
    case .downToTop:
        return CGPoint(x: initialPoint.x, y: initialPoint.y - distance)
    case .leftToRight:
        return CGPoint(x: initialPoint.x + distance, y: initialPoint.y)
    case .rightToLeft:
        return CGPoint(x: initialPoint.x - distance, y: initialPoint.y)
    default:
        return CGPoint(x: initialPoint.x, y: initialPoint.y + distance)
    }
}

fileprivate func randomScaleSize(for size:CGSize, sizeVariation:CGFloat)->CGSize{
    var randomScale:CGFloat = CGFloat(drand48()) * sizeVariation
    randomScale = drand48() < 0.5 ? randomScale : randomScale * -1
    let width = (size.width * randomScale) + size.width
    let height = (size.height * randomScale) + size.height
    return CGSize(width: width, height: height)
    
}


fileprivate func buildCircleUIImage(size:CGFloat,color:UIColor)->UIImage{
    UIGraphicsBeginImageContext(CGSize(width: size, height: size))
    //UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), true, 1)
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.setFillColor(color.cgColor)
    ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: size, height: size))
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
}

fileprivate func buildSquareUIImage(size:CGFloat,color:UIColor)->UIImage{
    UIGraphicsBeginImageContext(CGSize(width: size, height: size))
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.setFillColor(color.cgColor)
    ctx.fill(CGRect(x: 0, y: 0, width: size, height: size))
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
}

fileprivate func buildTriangleUIImage(size:CGFloat,color:UIColor)->UIImage{
    UIGraphicsBeginImageContext(CGSize(width: size, height: size))
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.beginPath()
    ctx.move(to: CGPoint(x: size / 2, y: 0))
    ctx.addLine(to: CGPoint(x: size, y: size))
    ctx.addLine(to: CGPoint(x: 0, y: size))
    ctx.closePath()
    ctx.setFillColor(color.cgColor)
    ctx.fillPath()
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
}
