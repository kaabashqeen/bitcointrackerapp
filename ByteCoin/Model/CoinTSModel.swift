//
//  CoinTSModel.swift
//  ByteCoin
//
//  Created by Kaab Ashqeen on 7/1/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinTSModel: Decodable {
    let time: String
    let openP: Double // 19436.95,
    let high: Double // 19440.05,
    let low: Double // 19424.73,
    let close: Double // 19426.83,
    let volume: Double //11.53963455,
    let trades: Int //163
}
