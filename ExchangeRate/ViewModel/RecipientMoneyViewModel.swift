//
//  RecipientMoneyViewModel.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/09.
//

import UIKit

struct RecipientMoneyViewModel {
    let exchangeRateMoney: ExchangeRateMoney
    let perDollar: Int
    
    let exchangeRateFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal //천 단위 콤마(,)
        formatter.maximumFractionDigits = 2 // 최대 소수점 단위
        return formatter
    }()
    
    func exchangeRateMoneyFinal(money: Double) -> String {
        let exchangeRateFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal //천 단위 콤마(,)
            formatter.maximumFractionDigits = 2 // 최대 소수점 단위
            return formatter
        }()
        return (exchangeRateFormatter.string(from: money as NSNumber) ?? "")
    }
    
    var exchangeRateUSDPHP: String {
        let money = exchangeRateMoney.quotes.USDPHP * Double(perDollar)
        return "수취금액은 " + exchangeRateMoneyFinal(money: money) + " PHP 입니다."
    }
    
    var exchangeRateUSDJPY: String {
        let money = exchangeRateMoney.quotes.USDJPY * Double(perDollar)
        return "수취금액은 " + exchangeRateMoneyFinal(money: money) + " JPY 입니다."
    }
    
    var exchangeRateUSDKRW: String {
        let money = exchangeRateMoney.quotes.USDKRW * Double(perDollar)
        return "수취금액은 " + exchangeRateMoneyFinal(money: money) + " KRW 입니다."
    }
}

