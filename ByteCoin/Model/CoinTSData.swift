//
//  CoinTSData.swift
//  ByteCoin
//
//  Created by Kaab Ashqeen on 7/1/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinTSData: Decodable {
    let time_period_start: String // "2022-07-01T05:59:00.0000000Z",
    let time_period_end: String // "2022-07-01T06:00:00.0000000Z",
    let time_open: String //"2022-07-01T05:59:01.0748670Z",
    let time_close: String // "2022-07-01T05:59:48.4471800Z",
    let price_open: Double // 19436.95,
    let price_high: Double // 19440.05,
    let price_low: Double // 19424.73,
    let price_close: Double // 19426.83,
    let volume_traded: Double //11.53963455,
    let trades_count: Int //163
}

//
//struct CoinTSData: Decodable {
//    let timePeriod: [TimePeriod]
//}
//
//struct TimePeriod: Decodable {
//    let time_period_start: String // "2022-07-01T05:59:00.0000000Z",
//    let time_period_end: String // "2022-07-01T06:00:00.0000000Z",
//    let time_open: String //"2022-07-01T05:59:01.0748670Z",
//    let time_close: String // "2022-07-01T05:59:48.4471800Z",
//    let price_open: Double // 19436.95,
//    let price_high: Double // 19440.05,
//    let price_low: Double // 19424.73,
//    let price_close: Double // 19426.83,
//    let volume_traded: Double //11.53963455,
//    let trades_count: Int //163
//}

//struct TimePeriod: Decodable {
//    let time_period_start: String, // "2022-07-01T05:59:00.0000000Z",
//    let time_period_end: String, // "2022-07-01T06:00:00.0000000Z",
//    let time_open: String, //"2022-07-01T05:59:01.0748670Z",
//    let time_close: String, // "2022-07-01T05:59:48.4471800Z",
//    let price_open: Double, // 19436.95,
//    let price_high: Double, // 19440.05,
//    let price_low: Double, // 19424.73,
//    let price_close: Double, // 19426.83,
//    let volume_traded: Double, //11.53963455,
//    let trades_count: Int //163
//}
