//
//  CoinData.swift
//  ByteCoin
//
//  Created by Kaab Ashqeen on 6/27/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
