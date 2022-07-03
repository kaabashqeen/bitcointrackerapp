//
//  GraphViewController.swift
//  ByteCoin
//
//  Created by Kaab Ashqeen on 7/1/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
import UIKit
import LightweightCharts

class GraphViewController: UIViewController {
    @IBOutlet weak var lightweightChart: LightweightCharts!
    
//    var chart: LightweightCharts!
    var coinTSManager = CoinTSManager()
//    var series: BarSeries!
//    var series: LineSeries!
    let isoFormatter = ISO8601DateFormatter()
    var series: CandlestickSeries!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        chart = LightweightCharts()
        isoFormatter.formatOptions = [.withFullDate,.withTime, .withFractionalSeconds,.withDashSeparatorInDate,.withColonSeparatorInTime]
        
//        self.view.addSubview(chart)
//        chart.sizeToFit()
//        series = lightweightChart.addBarSeries(options: BarSeriesOptions(lastValueVisible: true, title: "BTC", priceScaleId: nil, visible: true, priceLineVisible: true, priceLineSource: nil, priceLineWidth: nil, priceLineColor: nil, priceLineStyle: nil, priceFormat: nil, baseLineVisible: nil, baseLineColor: nil, baseLineWidth: nil, baseLineStyle: nil, autoscaleInfoProvider: nil, upColor: nil, downColor: nil, openVisible: nil, thinBars: nil))
        
        
        
//        series = lightweightChart.addBarSeries(options: nil)
        
        
        
        
//        chart.frame = CGRect(x: view.center.x, y: view.center.y, width: view.bounds.width, height: 300)
//        series = lightweightChart.addCandlestickSeries(options: nil)
//        print(lightweightChart.series)
//        let data = [
//            BarData(time: .utc(timestamp: 1656806215.234), open: 180.34, high: 180.99, low: 178.57, close: 179.85),
//            BarData(time: .utc(timestamp: 1656806315.1542), open: 180.82, high: 181.40, low: 177.56, close: 178.75),
//            BarData(time: .utc(timestamp: 1656806415.435), open: 175.77, high: 179.49, low: 175.44, close: 178.53),
//            BarData(time: .utc(timestamp: 1656806515.4543), open: 178.58, high: 182.37, low: 176.31, close: 176.97),
//            BarData(time: .utc(timestamp: 1656806615.643), open: 177.52, high: 180.50, low: 176.83, close: 179.07)
//        ]
//        let data = [
//                    LineData(time: .utc(timestamp: 1656806215.234), value: 180.34),
//                    LineData(time: .utc(timestamp: 1656806315.1542), value: 180.82),
//                    LineData(time: .utc(timestamp: 1656806415.435), value: 175.77),
//                    LineData(time: .utc(timestamp: 1656806515.4543), value: 178.58),
//                    LineData(time: .utc(timestamp: 1656806615.643), value: 177.52)
//                ]
//        print("start data")
//        print(data)
//        print("end data")
//        // ...
//        series.setData(data: data)
        updateChart()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinTSManager.delegate = self
//        self.lightweightChart.sizeToFit()
//        self.lightweightChart.timeScale().resetTimeScale()
//        self.lightweightChart.applyOptions(options: ChartOptions(width: nil, height: nil, watermark: nil, layout: nil, leftPriceScale: VisiblePriceScaleOptions(autoScale: true, mode: nil, invertScale: nil, alignLabels: nil, scaleMargins: nil, borderVisible: true, borderColor: nil, entireTextOnly: nil, visible: true, drawTicks: true), rightPriceScale: VisiblePriceScaleOptions(autoScale: true, mode: nil, invertScale: nil, alignLabels: nil, scaleMargins: nil, borderVisible: true, borderColor: nil, entireTextOnly: nil, visible: true, drawTicks: true), overlayPriceScales: nil, timeScale: TimeScaleOptions(rightOffset: nil, barSpacing: nil, minBarSpacing: nil, fixLeftEdge: nil, fixRightEdge: nil, lockVisibleTimeRangeOnResize: nil, rightBarStaysOnScroll: nil, borderVisible: true, borderColor: nil, visible: true, timeVisible: true, secondsVisible: true, shiftVisibleRangeOnNewBar: nil, tickMarkFormatter: nil), crosshair: nil, grid: nil, localization: nil, handleScroll: nil, handleScale: nil, kineticScroll: nil, trackingMode: nil))
        
    }
    
    func updateChart() {
        coinTSManager.getCoinTSPrices(for: 1440)
    }
}


extension GraphViewController: CoinTSManagerDelegate {
    func didUpdateCoinTS(_ coinTSManager: CoinTSManager, coinTSModels: [CoinTSModel]) {
        DispatchQueue.main.async {
//            self.series = self.lightweightChart.addLineSeries(options: nil)
            
//            self.chart.frame = self.view.bounds
            
//            var data: [LineData] = []
//            self.series = self.lightweightChart.addBarSeries(options: nil)
            self.series = self.lightweightChart.addCandlestickSeries(options: nil)
            var data: [CandlestickData] = []
//            var data: [BarData] = []
            
            var count = 0
            for coinTS in coinTSModels {
                let time = coinTS.time
//                data.append(BarData(time: .string(time), open: coinTS.openP, high: coinTS.high, low: coinTS.low, close: coinTS.close))
                
                let date = self.isoFormatter.date(from: time)?.timeIntervalSince1970 ?? 0
                
//                data.append(BarData(time: .utc(timestamp: date), open: coinTS.openP, high: coinTS.high, low: coinTS.low, close: coinTS.close))
//                print(date, coinTS.openP, coinTS.high, coinTS.low, coinTS.close)
                data.append(CandlestickData(time: .utc(timestamp: date), open: coinTS.openP, high: coinTS.high, low: coinTS.low, close: coinTS.close))
//                print(data[count].time, coinTS.close)
                count+=1
//                data.append(LineData(time: .utc(timestamp: date), value: coinTS.close))
//                print(date, coinTS.openP, coinTS.high, coinTS.low, coinTS.close)
//                if count >= 5 {
//                    break
//                }
            }
            data.reverse()
            print("start data")
            print(data)
            print("end data")
            self.series.setData(data: data)
            
//            self.viewDidLoad()
//            print(self.)
//            print(self.lightweightChart.timeScale().options()
            
//            print(self.lightweightChart.priceScale(priceScaleId: nil).options(completi
//            }))
            
//            self.lightweightChart.applyOptions(options: ChartOptions(width: nil, height: nil, watermark: nil, layout: nil, leftPriceScale: VisiblePriceScaleOptions(autoScale: true, mode: nil, invertScale: nil, alignLabels: nil, scaleMargins: nil, borderVisible: true, borderColor: nil, entireTextOnly: nil, visible: true, drawTicks: true), rightPriceScale: VisiblePriceScaleOptions(autoScale: true, mode: nil, invertScale: nil, alignLabels: nil, scaleMargins: nil, borderVisible: true, borderColor: nil, entireTextOnly: nil, visible: true, drawTicks: true), overlayPriceScales: nil, timeScale: TimeScaleOptions(rightOffset: nil, barSpacing: 1.0, minBarSpacing: nil, fixLeftEdge: nil, fixRightEdge: nil, lockVisibleTimeRangeOnResize: false, rightBarStaysOnScroll: nil, borderVisible: true, borderColor: nil, visible: true, timeVisible: true, secondsVisible: true, shiftVisibleRangeOnNewBar: nil, tickMarkFormatter: nil), crosshair: nil, grid: nil, localization: nil, handleScroll: nil, handleScale: nil, kineticScroll: nil, trackingMode: nil))
//            self.lightweightChart.sizeToFit()
//            self.lightweightChart.timeScale().resetTimeScale()
//            self.series.applyOptions(options: BarSeriesOptions(lastValueVisible: true, title: "BTC", priceScaleId: nil, visible: true, priceLineVisible: true, priceLineSource: nil, priceLineWidth: nil, priceLineColor: nil, priceLineStyle: nil, priceFormat: nil, baseLineVisible: true, baseLineColor: nil, baseLineWidth: nil, baseLineStyle: nil, autoscaleInfoProvider: nil, upColor: nil, downColor: nil, openVisible: true, thinBars: nil))
            
//            self.lightweightChart.sizeToFit()
    //        self.lightweightChart.timeScale().resetTimeScale()
//            self.lightweightChart.applyOptions(options: ChartOptions(width: nil, height: nil, watermark: nil, layout: nil, leftPriceScale: VisiblePriceScaleOptions(autoScale: true, mode: nil, invertScale: nil, alignLabels: nil, scaleMargins: nil, borderVisible: true, borderColor: nil, entireTextOnly: nil, visible: true, drawTicks: true), rightPriceScale: VisiblePriceScaleOptions(autoScale: true, mode: nil, invertScale: nil, alignLabels: nil, scaleMargins: nil, borderVisible: true, borderColor: nil, entireTextOnly: nil, visible: true, drawTicks: true), overlayPriceScales: nil, timeScale: TimeScaleOptions(rightOffset: nil, barSpacing: nil, minBarSpacing: nil, fixLeftEdge: nil, fixRightEdge: nil, lockVisibleTimeRangeOnResize: nil, rightBarStaysOnScroll: nil, borderVisible: true, borderColor: nil, visible: true, timeVisible: true, secondsVisible: true, shiftVisibleRangeOnNewBar: nil, tickMarkFormatter: nil), crosshair: nil, grid: nil, localization: nil, handleScroll: nil, handleScale: nil, kineticScroll: nil, trackingMode: nil))
        }

    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
