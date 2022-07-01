//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "BF4EBD78-B2EA-4A60-965D-B0C84B9EE11E"
    
    var delegate: CoinManagerDelegate?
    
    /* https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=BF4EBD78-B2EA-4A60-965D-B0C84B9EE11E */
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
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
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let price = decodedData.rate
            let currency = decodedData.asset_id_quote
            let crypto = decodedData.asset_id_base
            
            let coin = CoinModel(crypto: crypto, currency: currency, price: price)
            
            return coin
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil 
        }
    }
    
}
