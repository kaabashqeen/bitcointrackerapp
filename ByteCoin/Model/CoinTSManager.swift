//
//  CoinTSManager.swift
//  ByteCoin
//
//  Created by Kaab Ashqeen on 7/1/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation


//https://rest.coinapi.io/v1/ohlcv/COINBASE_SPOT_BTC_USD/latest?period_id=1MIN&limit=1440&include_empty_items=false&apiKey=BF4EBD78-B2EA-4A60-965D-B0C84B9EE11E

protocol CoinTSManagerDelegate {
    func didUpdateCoinTS(_ coinTSManager: CoinTSManager, coinTSModels: [CoinTSModel])
    func didFailWithError(error: Error)
}
struct CoinTSManager {
    
    let baseURL = "https://rest.coinapi.io/v1/ohlcv/COINBASE_SPOT_BTC_USD/latest"
    let apiKey = "BF4EBD78-B2EA-4A60-965D-B0C84B9EE11E"
//    let apiKey = "823D7F10-F4E0-48E0-BC0A-AA18DC2AFE4C"
//    let apiKey = "A473FBCE-D405-4C9C-A229-A4DC92A13C8F"
    let period_id = "1MIN"
    let include_empty_items = "false"
    
    var delegate: CoinTSManagerDelegate?
    

    func getCoinTSPrices(for limit: Int) {
        
        let urlString = "\(baseURL)?period_id=\(period_id)&limit=\(String(limit))&include_empty_items=\(include_empty_items)&apiKey=\(apiKey)"
        
        print(urlString)
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String) {
        //1. create a url
        if let url = URL(string: urlString) {
            
            //2. create a url session. this creates the browser to do the networking
            let session = URLSession(configuration: .default)
            
            //3. give the task a session
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coinTS = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoinTS(self, coinTSModels: coinTS)
                    }
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinTSData: Data) -> [CoinTSModel]? {
        let decoder = JSONDecoder()
        print("in parse")
        do {
            print("trying")
            print(coinTSData)
            let decodedData = try decoder.decode([CoinTSData].self, from: coinTSData)
            var coinTSModels: [CoinTSModel] = []
            for timePeriod in decodedData {
                var time = timePeriod.time_period_end
                var open = timePeriod.price_open
                var high = timePeriod.price_high
                var low = timePeriod.price_low
                var close = timePeriod.price_close
                var volume = timePeriod.volume_traded
                var trades = timePeriod.trades_count
                var coinTS = CoinTSModel(time: time, openP: open, high: high, low: low, close: close, volume: volume, trades: trades)
                coinTSModels.append(coinTS)
            }
            print("made it")
            return coinTSModels
    
        } catch {
            print("failed")
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}



