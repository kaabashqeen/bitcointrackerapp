//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Kaab Ashqeen on 6/27/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel: Decodable {
    let crypto: String
    let currency: String
    let price: Double
    
    var priceString: String {
        return String(format: "%.2f", price)
    }
}
