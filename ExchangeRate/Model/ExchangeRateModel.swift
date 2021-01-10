//
//  ExchangeRateModel.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import Foundation

struct ExchangeRateMoney: Decodable {
    var quotes: Quotes
}

struct Quotes: Decodable {
    var USDKRW: Double
    var USDJPY: Double
    var USDPHP: Double
}
