//
//  ScrollableChart.swift
//  SwiftyScrollableGraph
//
//  Created by Георгий on 26.09.17.
//  Copyright © 2017 Георгий. All rights reserved.
//

import UIKit

public class SwiftyScrollableGraph: UIScrollView, UIScrollViewDelegate {

    private var bezierView = BezierView()
    
    private var bezierViewWidthConstraint = NSLayoutConstraint()
    
    private var graphLeftConstraint  = NSLayoutConstraint()
    
    private var  graphRightConstraint = NSLayoutConstraint()
    
    private let valueLabel = UILabel(frame: CGRect(x: 0, y: 22, width: 73, height: 25))
    private let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 3, width: 73, height: 25))
    private var viewsToClear = [UIView]()
    private var layersToClear = [CAShapeLayer]()
    
    public var infoView: UIView?
    public var leftSpacer: CGFloat = 150
    public var rightSpacer: CGFloat = 150
    public var showHorizontalIndicator = false
    public var spaceBetweenPoints: CGFloat = 100

    public struct DesignEntity {
        public var color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public var size: CGFloat = 5
        public var isOn = true
    }
    
    public var pickedPoint = DesignEntity(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), size: 15, isOn: true )
    public var points =  DesignEntity(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: 15, isOn: true)
    public var chartLine = DesignEntity(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: 2, isOn: true)
    public var xAxisLine = DesignEntity(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: 1, isOn: false)
    public var yAxisLine = DesignEntity(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: 1, isOn: false)

    public var animates = true
    public var animationTime: CFTimeInterval = 1
    public var autoScroll = false
    
    
    private var topSafeArea: CGFloat {
        return self.frame.height / 10
    }
    
    
    private func setupConstraints () {
        
        self.clipsToBounds = true
        self.delegate = self
        
        self.showsHorizontalScrollIndicator = self.showHorizontalIndicator
        
        infoView?.removeFromSuperview()
        
        bezierView.removeFromSuperview()
        self.addSubview(bezierView)
        bezierView.layer.zPosition = 1
        
        bezierView.removeConstraint(bezierViewWidthConstraint)
        self.removeConstraints([graphLeftConstraint,graphRightConstraint])
        
        //задаем безопасное расстояние сверху и снизу основываясь на размере нашего скролвью
        
        bezierView.frame = CGRect(x: leftSpacer, y:  topSafeArea , width: self.frame.width, height: self.frame.height - topSafeArea * 2)
        print("bezierView.frame \(bezierView.frame)")
     
        graphLeftConstraint  = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: bezierView, attribute: .leading, multiplier: 1, constant: leftSpacer)
         graphRightConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: bezierView, attribute: .trailing, multiplier: 1, constant: rightSpacer)
        
        bezierViewWidthConstraint = NSLayoutConstraint(item: bezierView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        bezierView.addConstraints([bezierViewWidthConstraint])
        self.addConstraints([graphLeftConstraint,graphRightConstraint])
    }
 
    
    public func scrollViewDidScroll(_: UIScrollView) {
        
        //рассчитываем Х координаты центра экрана относительно начала
        print(self.contentOffset.x + self.frame.size.width / 2 )
        let currentMidX = self.contentOffset.x + self.frame.size.width / 2
        //leftSpacer - коеффицент на который сдвинут график от левого края скролвью
        for (index,point) in getGraphPoints().enumerated() {
            if point.x  > (currentMidX - spaceBetweenPoints / 2 - leftSpacer) && point.x < (currentMidX + spaceBetweenPoints / 2 - leftSpacer)   {
                
                if infoView == nil {
                     infoView = UIView(frame: CGRect(x: 0, y: 0, width: 73, height: 50))
                }
                infoView!.removeFromSuperview()
                
                
                if Double(point.y - pickedPoint.size - topSafeArea) < getyAxisPoints().min()! {
                    //print("THIS POINT IS UNDERLINE!")
                    infoView!.center = CGPoint(x:point.x + leftSpacer, y: point.y + pickedPoint.size + infoView!.frame.height / 2 + 30 )
                } else {
                    infoView!.center = CGPoint(x:point.x + leftSpacer, y: point.y - 10  )
                }
                
                infoView!.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.2862745098, blue: 0.3333333333, alpha: 0.65)
                infoView!.layer.cornerRadius = 4
                infoView!.clipsToBounds = true
                
                valueLabel.removeFromSuperview()
                valueLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
                valueLabel.text = "\(pointsData[index].value)"
                valueLabel.textAlignment = .center
                valueLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                infoView!.addSubview(valueLabel)
              
                descriptionLabel.removeFromSuperview()
                descriptionLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
                let dateText = pointsData[index].description ?? ""
                descriptionLabel.text = dateText
                descriptionLabel.textAlignment = .center
                descriptionLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                infoView!.addSubview(descriptionLabel)
                
                bezierView.placePoint(atPoint: point)
                
                self.addSubview(infoView!)
                infoView?.layer.zPosition = 2

            }
        }
    }
    
    private var pointsData = [(value: Int, description: String?)]()
    
    
    
    private func getxAxisPoints() -> [Double]  {
        var points = [Double]()
        for i in 0..<pointsData.count {
            
            let val = (Double(i)/Double(pointsData.count - 1)) * self.bezierView.frame.width.f
            points.append(val)
        }
        
        return points
        
    }
    
    private var pointValues: [Int] {
        
        var _pointValues = [Int]()
        for (pointValue, _) in pointsData {
            _pointValues.append(pointValue)
        }
        return _pointValues
    }
    
    private func getyAxisPoints() -> [Double] {
        var points = [Double]()
        
        
        for i in pointValues {
            let val = (Double(i)/Double(pointValues.max()! )) * self.bezierView.frame.height.f
            points.append(val)
        }
        
        return points
        
    }
    
    private func getGraphPoints() -> [CGPoint] {
        var points = [CGPoint]()
        let xPoints = self.getxAxisPoints()
        let yPoints = self.getyAxisPoints()
        
        for i in 0..<pointsData.count {
            let val = CGPoint(x: xPoints[i], y: ( -1 * yPoints[i] + self.bezierView.frame.height.f ))
            points.append(val)
        }
        
        return points
        
    }
    
    private func getInfoPoints() ->  [CGPoint] {
        
        var points = [CGPoint]()
        let xPoints = self.getxAxisPoints()
        let yPoints = self.getyAxisPoints()
        
        for i in 0..<pointsData.count {
            let val = CGPoint(x: xPoints[i], y: yPoints[i]  )
            points.append(val)
        }
        
        return points
        
    }
    
    
    public func reloadGraphWith(pointsData: [(value: Int, description: String?)] ) {
        
        self.pointsData = pointsData

        //чистим
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        for view in viewsToClear {
            view.removeFromSuperview()
        }
        for layer in layersToClear {
            layer.removeFromSuperlayer()
        }
        
        //настраиваем констрейнты
        setupConstraints()
        
        //передаем данные в наш безье вью
        bezierView.animationTime = self.animationTime
        bezierView.animates = self.animates
        bezierView.lineSize = self.chartLine.size
        bezierView.lineColor = self.chartLine.color
        bezierView.pointsColor = self.points.color
        bezierView.pointsSize = Int(self.points.size)
        bezierView.pickedPointSize = Int(self.pickedPoint.size)
        bezierView.pickedPointColor = self.pickedPoint.color
        
        guard pointsData.count > 1 else {
            bezierView.clear()
            self.pointsData.removeAll()
            
            return
        }

        bezierViewWidthConstraint.constant = CGFloat(pointsData.count * Int(spaceBetweenPoints))
        bezierView.frame.size.width = CGFloat(pointsData.count * Int(spaceBetweenPoints))
        bezierView.dataPoints = getGraphPoints()
        
        bezierView.redraw()
        
        
        if xAxisLine.isOn {
            drawXlines()
        }
        if yAxisLine.isOn {
            drawYlines()
        }
        
        if autoScroll {
            self.setContentOffset(CGPoint(x: bezierView.frame.width, y: 0), animated: true)

        }

    }
    
    public func reloadGraph() {
        
        guard self.pointsData.count > 1 else {
            bezierView.clear()
            self.pointsData.removeAll()
            return
        }

        
        //чистим
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        for view in viewsToClear {
            view.removeFromSuperview()
        }
        for layer in layersToClear {
            layer.removeFromSuperlayer()
        }
        
        //настраиваем констрейнты
        setupConstraints()
        
        //передаем данные в наш безье вью
        bezierView.animationTime = self.animationTime
        bezierView.animates = self.animates
        bezierView.lineSize = self.chartLine.size
        bezierView.lineColor = self.chartLine.color
        bezierView.pointsColor = self.points.color
        bezierView.pointsSize = Int(self.points.size)
        bezierView.pickedPointSize = Int(self.pickedPoint.size)
        bezierView.pickedPointColor = self.pickedPoint.color
        
        
        bezierViewWidthConstraint.constant = CGFloat(self.pointsData.count * Int(spaceBetweenPoints))
        bezierView.frame.size.width = CGFloat(self.pointsData.count * Int(spaceBetweenPoints))
        bezierView.dataPoints = getGraphPoints()
        
        bezierView.redraw()
        
        if xAxisLine.isOn {
            drawXlines()
        }
        if yAxisLine.isOn {
            drawYlines()
        }
        
        if autoScroll {
            self.setContentOffset(CGPoint(x: bezierView.frame.width, y: 0), animated: true)
        }
        
    }

    
    
    private func drawYlines() {
        for (index,point) in self.getGraphPoints().enumerated() {
            drawLine(fromPoint: CGPoint(x: point.x + leftSpacer, y: 0 ), toPoint: CGPoint(x: point.x + leftSpacer, y: self.frame.height ), color: yAxisLine.color)
            
            let axisDeskLabel = UILabel(frame: CGRect(x: 0, y: 0, width: spaceBetweenPoints, height: 50))
            axisDeskLabel.font = axisDeskLabel.font.withSize(12)
            axisDeskLabel.text = pointsData[index].description
            axisDeskLabel.textColor = yAxisLine.color
            axisDeskLabel.center = CGPoint(x: point.x + leftSpacer + spaceBetweenPoints / 2 + 3, y: self.frame.height - 14 )
            self.addSubview(axisDeskLabel)
            self.viewsToClear.append(axisDeskLabel)

        }
    }
    
    private func drawXlines() {
        
        for index in 0...10 {
            drawLine(fromPoint: CGPoint(x: -self.frame.width, y: CGFloat(index) * (self.frame.height - topSafeArea * 2 ) / 10 + topSafeArea  ), toPoint: CGPoint(x: bezierView.frame.size.width + rightSpacer + leftSpacer + self.frame.width * 2, y: CGFloat(index) * (self.frame.height - topSafeArea * 2 ) / 10 + topSafeArea  ), color: xAxisLine.color)
            
            let axisDeskLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            axisDeskLabel.font = axisDeskLabel.font.withSize(12)
            axisDeskLabel.textColor = xAxisLine.color
            axisDeskLabel.text = "\(pointValues.max()! - pointValues.max()! / 10 * index)"
            axisDeskLabel.center = CGPoint(x: 30, y: CGFloat(index) * (self.frame.height - topSafeArea * 2 ) / 10 + topSafeArea + self.frame.minY - 7  ) // 7 - рзамер самой буквы
            self.superview?.addSubview(axisDeskLabel)
            self.viewsToClear.append(axisDeskLabel)


        }
    }

    
    private func drawLine(fromPoint start: CGPoint, toPoint end:CGPoint, color: UIColor) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = color.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.layer.addSublayer(line)
        self.layersToClear.append(line)
    }
    

    

}
