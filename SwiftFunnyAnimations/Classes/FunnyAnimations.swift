//
//  FunnyAnimations.swift
//  Pods-SwiftFunnyAnimations_Example
//
//  Created by Miguel Machado on 12/11/19.
//

import UIKit


public class FunnyAnimations{
    
    /// The view where the particles are added, can be a window
    private let rootView:UIView
    
    /**
     Initialize instance of FunnyAnimations.
     - Parameters:
     - rootview: The view where the particles are added, can be a window
     - Returns: A FunnyAnimations instanse.
     */
    public required init(rootview:UIView){
        self.rootView = rootview
    }
    
    // MARK: Enums
    public enum Direction{
        case toDown
        case toTop
        case toRight
        case toLeft
    }
    public enum Shape{
        case square
        case circle
        case triangle
    }
    
    
    // MARK: Default static values
    private static let defaultColors:[UIColor] = [
        UIColor.red,
        UIColor.blue
    ]
    private static let defaultSize:CGFloat = 10
    
    
    // MARK: Private vars
    private var particlesSprites : [UIImage] = []
    private var particlesSpritesTints : [UIColor?] = []
    
    /// Total of particles types
    public var totalParticlesTypes:Int {
        get{
            return self.particlesSprites.count
        }
    }
    
    // MARK: Public Methods
    
    /**
     Build and append shape particles (triangles, squares and circles) .
     - Parameters:
     - shapes:  shapes to build
     - size:    default size for the particles, default is 10
     - colors:  Color of particles default is [UIcolor.red,UIColor.blue]
     */
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
    
    /**
     Append particles from UIImage instances.
     - Parameters:
     - images:      array of UIImage´s
     - tintColors:  Optional
     */
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
    
    /**
     Clear all particles.
     */
    public func clearParticlesTypes(){
        self.particlesSpritesTints.removeAll()
        self.particlesSprites.removeAll()
    }
    
    /**
     Start a "WaveRain" animation. a rain of particles will fall from one side of the rootView to the other
     - Parameters:
     - total:           total of particles in animation
     - direction:       can be .toDown .toTop .toRight .toLeft
     - sizeVariation:   0 = no variation, 0.5 the particles will appear from 50% to 150% of their original size
     - randomRotation:  if is true the particles will appear with random rotation values
     */
    public func startWaveRain(total:Int,direction:Direction,sizeVariation:CGFloat,randomRotation:Bool){
        if self.totalParticlesTypes <= 0 {return}
        
        for _ in 1...total{
    
            let imageView:UIImageView = getRandomParticle(sizeVariation: sizeVariation, randomRotation: randomRotation )
            
            let animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
    
            let initialPoint:CGPoint
            switch direction{
            case .toTop:
                initialPoint = CGPoint(x: CGFloat(drand48()) * rootView.frame.width, y: rootView.frame.height + 50)
                break
            case .toRight:
                initialPoint = CGPoint(x: -50, y: CGFloat(drand48()) * rootView.frame.height)
                break
            case .toLeft:
                initialPoint = CGPoint(x: rootView.frame.width + 50, y: CGFloat(drand48()) * rootView.frame.height)
                break
            default:
                initialPoint = CGPoint(x: CGFloat(drand48()) * rootView.frame.width, y: -50)
                
            }
            
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
    
    /**
     Start a "Wave" animation. the particles will appear from the center of the view to one of the edges of the rootView
     - Parameters:
     - view:            Is the view from where the particles appear
     - total:           total of particles in animation
     - direction:       can be .toDown .toTop .toRight .toLeft
     - sizeVariation:   0 = no variation, 0.5 the particles will appear from 50% to 150% of their original size
     - randomRotation:  if is true the particles will appear with random rotation values
     */
    public func startWave(from view:UIView,total:Int,direction:Direction,sizeVariation:CGFloat,randomRotation:Bool){
        let localPoint:CGPoint = CGPoint(x:view.frame.width / 2,y: view.frame.height / 2)
        let globalPoint = view.convert(localPoint, to: self.rootView)
        self.startWave(from: globalPoint, total: total, direction: direction, sizeVariation: sizeVariation, randomRotation: randomRotation)
    }
    
    /**
     Start a "Wave" animation. the particles will appear from one point to one of the edges of the rootView
     - Parameters:
     - point:           point from where the particles appear
     - total:           total of particles in animation
     - direction:       can be .toDown .toTop .toRight .toLeft
     - sizeVariation:   0 = no variation, 0.5 the particles will appear from 50% to 150% of their original size
     - randomRotation:  if is true the particles will appear with random rotation values
     */
    public func startWave(from point:CGPoint,total:Int,direction:Direction,sizeVariation:CGFloat,randomRotation:Bool){
        if self.totalParticlesTypes <= 0 {return}
        for _ in 1...total{
            
            let imageView:UIImageView = getRandomParticle(sizeVariation: sizeVariation,randomRotation: randomRotation)
            
            let animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
            
            let distance:CGFloat
            switch direction{
            case .toTop:
                distance = point.y + imageView.frame.height / 2
                break
            case .toRight:
                distance = self.rootView.frame.width - point.x + imageView.frame.width / 2
                break
            case .toLeft:
                distance = point.x + imageView.frame.width / 2
                break
            default:
                distance = self.rootView.frame.height - point.y + imageView.frame.height / 2
                
            }
            
            animation.delegate = AnimationDelegate(imageView)
            
            animation.path = FunnyAnimations.buildWaveAnimationPath(initialPoint: point, distance: distance, direction: direction,onlyOneSide: true).cgPath
            animation.duration = 1 + drand48() * 2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = true
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            imageView.layer.add(animation, forKey: nil)
            self.rootView.addSubview(imageView)
        }
    }
    
    
    // MARK: Private Methods
    
    /**
     Return a random particle from particlesSprites array
     - Parameters:
     - sizeVariation:   0 = no variation, 0.5 the particles will appear from 50% to 150% of their original size
     - randomRotation:  if is true the particles will appear with random rotation values
     */
    private func getRandomParticle(sizeVariation:CGFloat,randomRotation:Bool) -> UIImageView{
        let randomParticlesViewsIndex = Int(round( drand48() * Double(self.particlesSprites.count - 1)))
        let sprite:UIImage = self.particlesSprites[randomParticlesViewsIndex]
        let imageView:UIImageView = UIImageView(image: sprite)
        imageView.tintColor = self.particlesSpritesTints[randomParticlesViewsIndex]
        let size = randomScaleSize(for: imageView.frame.size, sizeVariation: sizeVariation)
        imageView.frame = CGRect(x: -size.width, y: -size.height, width: size.width, height: size.height)
        
        if randomRotation {
            let degrees = CGFloat(drand48() * 180)
            let radians = degrees / 180.0 * CGFloat.pi
            let rotation = imageView.transform.rotated(by: radians)
            imageView.transform = rotation
        }
        return imageView
    }
    
    private static func buildToRightAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat,
        onlyOneSide:Bool = false
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .toRight)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5 || onlyOneSide{
            cp1 = CGPoint(x: initialPoint.x + distance * 0.25, y: initialPoint.y + randomCurve)
            cp2 = CGPoint(x: initialPoint.x + distance * 0.50, y: initialPoint.y - randomCurve)
        }else{
            cp1 = CGPoint(x: initialPoint.x + distance * 0.25, y: initialPoint.y - randomCurve)
            cp2 = CGPoint(x: initialPoint.x + distance * 0.50, y: initialPoint.y + randomCurve)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildToLeftAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat,
        onlyOneSide:Bool = false
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .toLeft)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5 || onlyOneSide{
            cp1 = CGPoint(x: initialPoint.x - distance * 0.25, y: initialPoint.y + randomCurve)
            cp2 = CGPoint(x: initialPoint.x - distance * 0.50, y: initialPoint.y - randomCurve)
        }else{
            cp1 = CGPoint(x: initialPoint.x - distance * 0.25, y: initialPoint.y - randomCurve)
            cp2 = CGPoint(x: initialPoint.x - distance * 0.50, y: initialPoint.y + randomCurve)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildToDownAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat,
        onlyOneSide:Bool = false
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .toDown)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5 || onlyOneSide{
            cp1 = CGPoint(x: initialPoint.x + randomCurve, y: initialPoint.y + distance * 0.25)
            cp2 = CGPoint(x: initialPoint.x - randomCurve, y: initialPoint.y + distance * 0.50)
        }else{
            cp1 = CGPoint(x: initialPoint.x - randomCurve, y: initialPoint.y + distance * 0.25)
            cp2 = CGPoint(x: initialPoint.x + randomCurve, y: initialPoint.y + distance * 0.50)
        }
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    private static func buildToTopAnimationPath(
        initialPoint:CGPoint,
        distance:CGFloat,
        onlyOneSide:Bool = false
        ) -> UIBezierPath {
        let endPoint:CGPoint = getEndPoint(from: initialPoint, distance: distance, direction: .toTop)
        let path:UIBezierPath = UIBezierPath()
        path.move(to: initialPoint)
        let randomCurve:CGFloat = CGFloat(100 + drand48() * 200)
        let cp1:CGPoint
        let cp2:CGPoint
        if drand48() < 0.5 || onlyOneSide{
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
        direction:FunnyAnimations.Direction,
        onlyOneSide:Bool = false
        ) -> UIBezierPath {
        switch direction {
        case .toTop:
            return buildToTopAnimationPath(initialPoint: initialPoint, distance: distance, onlyOneSide:onlyOneSide )
        case .toRight:
            return buildToRightAnimationPath(initialPoint: initialPoint, distance: distance, onlyOneSide:onlyOneSide)
        case .toLeft:
            return buildToLeftAnimationPath(initialPoint: initialPoint, distance: distance, onlyOneSide:onlyOneSide)
        default:
            return buildToDownAnimationPath(initialPoint: initialPoint, distance: distance, onlyOneSide:onlyOneSide)
        }
    }


    
}
// MARK: AnimationDelegate

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

// MARK: Helpers functions

fileprivate func getEndPoint(from initialPoint:CGPoint,distance:CGFloat,direction:FunnyAnimations.Direction)->CGPoint{
    switch direction {
    case .toTop:
        return CGPoint(x: initialPoint.x, y: initialPoint.y - distance)
    case .toRight:
        return CGPoint(x: initialPoint.x + distance, y: initialPoint.y)
    case .toLeft:
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
