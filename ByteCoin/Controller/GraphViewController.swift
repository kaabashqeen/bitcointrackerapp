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
    var chart: LightweightCharts!
    var coinTSManager = CoinTSManager()
    var series: BarSeries!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chart = LightweightCharts()
        self.view.addSubview(chart)
        chart.sizeToFit()
        series = chart.addBarSeries(options: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinTSManager.delegate = self
        updateChart()
    }
    
    func updateChart() {
        
        coinTSManager.getCoinTSPrices(for: 1440)
    }
}


extension GraphViewController: CoinTSManagerDelegate {
    func didUpdateCoinTS(_ coinTSManager: CoinTSManager, coinTSModels: [CoinTSModel]) {
        DispatchQueue.main.async {
            self.chart.frame = self.view.bounds
            
            var data: [BarData] = []
            var count = 0
            for coinTS in coinTSModels {
                let time = coinTS.time
                data.append(BarData(time: .string(time), open: coinTS.openP, high: coinTS.high, low: coinTS.low, close: coinTS.close))
                print(data[count].time)
                count+=1
            }
            
            self.series.setData(data: data)
            self.chart.sizeToFit()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
