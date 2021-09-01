//
//  StatisticsGraphView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 01.09.2021.
//

import UIKit

protocol IStatisticsGraphView: UIView {
    func updateStatisticsData(recovered: Int, critical: Int, deaths: Int)
}

class StatisticsGraphView: UIView {

    // MARK: - Models

    private var totalCases: TotalCasesModel?

    // MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawGraph()
    }

    // MARK: - Drawing graph

    private func drawGraph() {
        guard let context = UIGraphicsGetCurrentContext(), let data = totalCases else { return }

        let sumCases = data.critical + data.recovered + data.deaths
        if sumCases == 0 {
            drawLine(start: 0, end: bounds.width, color: .systemGray6, context: context)
            return
        }

        let oneCaseWidth = bounds.width / sumCases
        let recoveredEndPoint = oneCaseWidth * data.recovered
        let criticalEndPoint = oneCaseWidth * data.critical + recoveredEndPoint

        drawLine(start: 0, end: recoveredEndPoint, color: ColorsConstants.recovered, context: context)
        drawLine(start: recoveredEndPoint, end: criticalEndPoint, color: ColorsConstants.critical, context: context)
        drawLine(start: criticalEndPoint, end: bounds.width, color: ColorsConstants.deaths, context: context)
    }

    private func drawLine(start: CGFloat, end: CGFloat, color: UIColor, context: CGContext) {
        context.setLineWidth(bounds.width)
        context.setStrokeColor(color.cgColor)
        context.move(to: CGPoint(x: start, y: bounds.height))
        context.addLine(to: CGPoint(x: end, y: bounds.height))
        context.strokePath()
    }
}

// MARK: - IStatisticsGraphView

extension StatisticsGraphView: IStatisticsGraphView {
    func updateStatisticsData(recovered: Int, critical: Int, deaths: Int) {
        totalCases = TotalCasesModel(recovered: CGFloat(recovered), critical: CGFloat(critical), deaths: CGFloat(deaths))
    }
}
