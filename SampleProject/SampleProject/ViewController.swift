//
//  ViewController.swift
//  SampleProject
//
//  Created by Георгий on 27.09.17.
//  Copyright © 2017 Георгий. All rights reserved.
//

import UIKit
import SwiftyScrollableGraph

class ViewController: UIViewController {
    
    @IBOutlet weak var swiftyScrollableGraph: SwiftyScrollableGraph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftyScrollableGraph.reloadGraphWith(pointsData: [(value: 11, description: "Jan."),(value: 2, description: "Feb."),(value: 33, description: "Mar."),(value: 0, description: "Apr."),(value: 5, description: "May"),(value: 1, description: "Jun."),(value: 6, description: "Jul."),(value: 31, description: "Aug."),(value: 4, description: "Sep."),(value: 0, description: "Oct."),(value: 22, description: "Nov."),(value: 22, description: "Dec.")])
        
    }
    
    @IBOutlet weak var dataSegmentControl: UISegmentedControl!
    @IBAction func dataSegmentControlChanged(_ sender: Any) {
        
        switch dataSegmentControl.selectedSegmentIndex {
        case 0:
            swiftyScrollableGraph.reloadGraphWith(pointsData: [(value: 11, description: "Jan."),(value: 2, description: "Feb."),(value: 33, description: "Mar."),(value: 0, description: "Apr."),(value: 5, description: "May"),(value: 1, description: "Jun."),(value: 6, description: "Jul."),(value: 31, description: "Aug."),(value: 4, description: "Sep."),(value: 0, description: "Oct."),(value: 22, description: "Nov."),(value: 22, description: "Dec.")])
            
        case 1:
            swiftyScrollableGraph.reloadGraphWith(pointsData: [(value: 0, description: "2010"),(value: 100, description: "2011"),(value: 0, description: "2012"),(value: 100, description: "2013"),(value: 55, description: "2014"),(value: 1, description: "2015"),(value: 5, description: "2016"),(value: 66, description: "2017"),(value: 3, description: "2018")])
            
        case 2:
            
            swiftyScrollableGraph.reloadGraphWith(pointsData: [(value: 0, description: "one"),(value: 100, description: "two"),(value: 0, description: "three"),(value: 100, description: "four"),(value: 55, description: "five"),(value: 1, description: "six"),(value: 5, description: "seven"),(value: 66, description: "eight"),(value: 3, description: "nine")])
            
            
            
        default:
            break
        }
        
    }
    
    @IBOutlet weak var designSegmentControl: UISegmentedControl!
    @IBAction func designSegmentControlChanged(_ sender: Any) {
        switch designSegmentControl.selectedSegmentIndex {
        case 0:
            swiftyScrollableGraph.autoScroll = true 
            swiftyScrollableGraph.infoView = nil
            swiftyScrollableGraph.backgroundColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            swiftyScrollableGraph.spaceBetweenPoints = 70
            swiftyScrollableGraph.animationTime = 1
            swiftyScrollableGraph.leftSpacer = 200
            swiftyScrollableGraph.rightSpacer = 200
            swiftyScrollableGraph.chartLine.color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swiftyScrollableGraph.chartLine.size = 2
            swiftyScrollableGraph.pickedPoint.size = 14
            swiftyScrollableGraph.pickedPoint.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            swiftyScrollableGraph.points.size = 14
            swiftyScrollableGraph.points.color = #colorLiteral(red: 0.9017687183, green: 0.9017687183, blue: 0.9017687183, alpha: 1)
            swiftyScrollableGraph.xAxisLine.isOn = false
            swiftyScrollableGraph.xAxisLine.size = 1
            swiftyScrollableGraph.xAxisLine.color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swiftyScrollableGraph.yAxisLine.isOn = false
            swiftyScrollableGraph.yAxisLine.size = 1
            swiftyScrollableGraph.yAxisLine.color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swiftyScrollableGraph.reloadGraph()
        case 1:
            swiftyScrollableGraph.infoView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            swiftyScrollableGraph.backgroundColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            swiftyScrollableGraph.spaceBetweenPoints = 35
            swiftyScrollableGraph.animationTime = 1
            swiftyScrollableGraph.leftSpacer = 200
            swiftyScrollableGraph.rightSpacer = 200
            swiftyScrollableGraph.chartLine.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            swiftyScrollableGraph.chartLine.size = 1
            swiftyScrollableGraph.pickedPoint.size = 0
            swiftyScrollableGraph.pickedPoint.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            swiftyScrollableGraph.points.size = 6
            swiftyScrollableGraph.points.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            swiftyScrollableGraph.xAxisLine.isOn = true
            swiftyScrollableGraph.xAxisLine.size = 1
            swiftyScrollableGraph.xAxisLine.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            swiftyScrollableGraph.yAxisLine.isOn = true
            swiftyScrollableGraph.yAxisLine.size = 1
            swiftyScrollableGraph.yAxisLine.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            swiftyScrollableGraph.reloadGraph()
            
        case 2:
            swiftyScrollableGraph.infoView = nil
            swiftyScrollableGraph.backgroundColor  = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swiftyScrollableGraph.spaceBetweenPoints = 70
            swiftyScrollableGraph.animationTime = 1
            swiftyScrollableGraph.leftSpacer = 200
            swiftyScrollableGraph.rightSpacer = 200
            swiftyScrollableGraph.chartLine.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            swiftyScrollableGraph.chartLine.size = 3
            swiftyScrollableGraph.pickedPoint.size = 11
            swiftyScrollableGraph.pickedPoint.color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            swiftyScrollableGraph.points.size = 11
            swiftyScrollableGraph.points.color = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            swiftyScrollableGraph.xAxisLine.isOn = true
            swiftyScrollableGraph.xAxisLine.size = 1
            swiftyScrollableGraph.xAxisLine.color = #colorLiteral(red: 0.1892094211, green: 0.1858699658, blue: 0.2130195114, alpha: 1)
            swiftyScrollableGraph.yAxisLine.isOn = true
            swiftyScrollableGraph.yAxisLine.size = 1
            swiftyScrollableGraph.yAxisLine.color = #colorLiteral(red: 0.1892094211, green: 0.1858699658, blue: 0.2130195114, alpha: 1)
            swiftyScrollableGraph.reloadGraph()
            
        case 3:
            swiftyScrollableGraph.infoView = nil
            swiftyScrollableGraph.backgroundColor  = #colorLiteral(red: 1, green: 0.2899605632, blue: 0.6305769682, alpha: 1)
            swiftyScrollableGraph.spaceBetweenPoints = 70
            swiftyScrollableGraph.animationTime = 1
            swiftyScrollableGraph.leftSpacer = 200
            swiftyScrollableGraph.rightSpacer = 200
            swiftyScrollableGraph.chartLine.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            swiftyScrollableGraph.chartLine.size = 2
            swiftyScrollableGraph.pickedPoint.size = 14
            swiftyScrollableGraph.pickedPoint.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            swiftyScrollableGraph.points.size = 14
            swiftyScrollableGraph.points.color = #colorLiteral(red: 0.9017687183, green: 0.9017687183, blue: 0.9017687183, alpha: 1)
            swiftyScrollableGraph.xAxisLine.isOn = false
            swiftyScrollableGraph.xAxisLine.size = 1
            swiftyScrollableGraph.xAxisLine.color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swiftyScrollableGraph.yAxisLine.isOn = false
            swiftyScrollableGraph.yAxisLine.size = 1
            swiftyScrollableGraph.yAxisLine.color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swiftyScrollableGraph.reloadGraph()
            
        case 4:
            swiftyScrollableGraph.infoView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            swiftyScrollableGraph.backgroundColor  = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            swiftyScrollableGraph.spaceBetweenPoints = 70
            swiftyScrollableGraph.animationTime = 1
            swiftyScrollableGraph.leftSpacer = 200
            swiftyScrollableGraph.rightSpacer = 200
            swiftyScrollableGraph.chartLine.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            swiftyScrollableGraph.chartLine.size = 1
            swiftyScrollableGraph.pickedPoint.size = 0
            swiftyScrollableGraph.pickedPoint.color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            swiftyScrollableGraph.points.size = 1
            swiftyScrollableGraph.points.color = #colorLiteral(red: 0.1892094211, green: 0.1858699658, blue: 0.2130195114, alpha: 1)
            swiftyScrollableGraph.xAxisLine.isOn = true
            swiftyScrollableGraph.xAxisLine.size = 1
            swiftyScrollableGraph.xAxisLine.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            swiftyScrollableGraph.yAxisLine.isOn = true
            swiftyScrollableGraph.yAxisLine.size = 1
            swiftyScrollableGraph.yAxisLine.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            swiftyScrollableGraph.reloadGraph()
            
        default:
            break
        }
    }
    
    
}
