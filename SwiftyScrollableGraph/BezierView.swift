//
//  BezierView.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/14/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation


class BezierView: UIView {
   
    fileprivate let kStrokeAnimationKey = "StrokeAnimationKey"
    fileprivate let kFadeAnimationKey = "FadeAnimationKey"
    
    
    var lineColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var lineSize:CGFloat = 0
    var pickedPointColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var pickedPointSize = 0
    var pointsColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var pointsSize = 0
    
    var pointsShadow = false
    var lineShadow = false
    
    var animates = true
    var animationTime: CFTimeInterval = 0
    
    var pointLayers = [CAShapeLayer]()
    var lineLayer = CAShapeLayer()
    
    var placedPoint = CAShapeLayer()
    
    //MARK: Private members
    
    var dataPoints: [CGPoint]?
    
    fileprivate var cubicCurveAlgorithm = CubicCurveAlgorithm()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    func redraw() {
        
        cubicCurveAlgorithm = CubicCurveAlgorithm()
        
        self.layer.sublayers?.forEach({ (layer: CALayer) -> () in
            layer.removeFromSuperlayer()
        })
        pointLayers.removeAll()
        
        drawSmoothLines()
        drawPoints()
        animateLayers()
        
    }
    
    func clear() {
        self.layer.sublayers?.forEach({ (layer: CALayer) -> () in
            layer.removeFromSuperlayer()
        })
        pointLayers.removeAll()
    }
    
    
    func placePoint(atPoint point: CGPoint){
        
        placedPoint.removeFromSuperlayer()
        placedPoint.bounds = CGRect(x: 0, y: 0, width: pickedPointSize, height: pickedPointSize)
        placedPoint.path = UIBezierPath(ovalIn: placedPoint.bounds).cgPath
        placedPoint.fillColor = pickedPointColor.cgColor
        placedPoint.position = point
        
        self.layer.addSublayer(placedPoint)

    }
    
    
    
    fileprivate func drawPoints(){
        
        guard let points = dataPoints else {
            return
        }
        
        for point in points {
            
            //здесь отрисовываем точки
            
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: pointsSize, height: pointsSize)
            circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
            circleLayer.fillColor = pointsColor.cgColor // UIColor(white: 248.0/255.0, alpha: 0.5).cgColor
            circleLayer.position = point
            
            if pointsShadow {
            circleLayer.shadowColor = UIColor.black.cgColor
            circleLayer.shadowOffset = CGSize(width: 0, height: 2)
            circleLayer.shadowOpacity = 0.7
            circleLayer.shadowRadius = 3.0
            }
            
            self.layer.addSublayer(circleLayer)
            
            if animates {
                circleLayer.opacity = 0
                pointLayers.append(circleLayer)
            }
 
        }
    }
    
    fileprivate func drawSmoothLines() {
        
        guard let points = dataPoints else {
            return
        }
        
        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(points)
        
        
        let linePath = UIBezierPath()
        
        for i in 0 ..< points.count {
            
            let point = points[i];
            
            if i==0 {
                linePath.move(to: point)
            } else {
                let segment = controlPoints[i-1]
                linePath.addCurve(to: point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
            }
        }
        
        lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        //толщина линии
        lineLayer.lineWidth = lineSize
        
        if lineShadow {
        //тень линии
        lineLayer.shadowColor = UIColor.black.cgColor
        lineLayer.shadowOffset = CGSize(width: 0, height: 8)
        lineLayer.shadowOpacity = 0.5
        lineLayer.shadowRadius = 6.0
        }
        
        self.layer.addSublayer(lineLayer)
        
        if animates {
            lineLayer.strokeEnd = 0
        }
    }
}

extension BezierView {
    
    func animateLayers() {
        animatePoints()
        animateLine()
    }
    
    func animatePoints() {
        
        var delay = animationTime  / Double(dataPoints!.count )
        
        
        for point in pointLayers {
            
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.toValue = 1
            fadeAnimation.beginTime = CACurrentMediaTime() + 0.2//delay * Double(index)
            fadeAnimation.duration = 0.2
            fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            fadeAnimation.fillMode = kCAFillModeForwards
            fadeAnimation.isRemovedOnCompletion = false
            point.add(fadeAnimation, forKey: kFadeAnimationKey)
            
            delay += 0.15
        }
    }
    
    func animateLine() {
        
        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.beginTime = CACurrentMediaTime() //+ 0.5
        growAnimation.duration = animationTime
        growAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        growAnimation.fillMode = kCAFillModeForwards
        growAnimation.isRemovedOnCompletion = false
        lineLayer.add(growAnimation, forKey: kStrokeAnimationKey)
    }
    
}

