//
//  BudgetTableCell.swift
//  Planda
//
//  Created by Prince Carter on 1/21/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import PieCharts

class BudgetTableCell: UITableViewCell, PieChartDelegate {
    
    @IBOutlet weak var chartView: PieChart!
    @IBOutlet weak var cellView: UIView!
    fileprivate static let alpha: CGFloat = 0.5
    
    let colors = [
        UIColor.yellow.withAlphaComponent(alpha),
        UIColor.green.withAlphaComponent(alpha),
        UIColor.purple.withAlphaComponent(alpha),
        UIColor.cyan.withAlphaComponent(alpha),
        UIColor.darkGray.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
    ]
    fileprivate var currentColorIndex = 0

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = cornerRadius
//        cellView.layer.shadowColor = UIColor.darkGray.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        cellView.layer.shadowRadius = 3.0
//        cellView.layer.shadowOpacity = 0.3
        
        chartView.layer.shadowColor = UIColor.darkGray.cgColor
        chartView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        chartView.layer.shadowRadius = 4.0
        chartView.layer.shadowOpacity = 0.6
        
        chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }

    
    // MARK: - PieChartDelegate
        func onSelected(slice: PieSlice, selected: Bool) {
            print("Selected: \(selected), slice: \(slice)")
        }
        
        // MARK: - Models
        
        fileprivate func createModels() -> [PieSliceModel] {

            let models = [
                PieSliceModel(value: 2, color: colors[0]),
                PieSliceModel(value: 2, color: colors[1]),
                PieSliceModel(value: 2, color: colors[2]),
                PieSliceModel(value: 2, color: colors[3]),
            ]
            
            currentColorIndex = models.count
            return models
        }
    
    // MARK: - Layers
    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 0)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.lightGray
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }
    
    @IBAction func onPlusTap(sender: UIButton) {
        let newModel = PieSliceModel(value: 4 * Double(CGFloat.random()), color: colors[currentColorIndex])
        chartView.insertSlice(index: 0, model: newModel)
        currentColorIndex = (currentColorIndex + 1) % colors.count
        if currentColorIndex == 2 {currentColorIndex += 1} // avoid same contiguous color
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
