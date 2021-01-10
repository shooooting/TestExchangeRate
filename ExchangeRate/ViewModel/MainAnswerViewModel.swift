//
//  ExchangeRateUSDViewModel.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import UIKit

struct MainAnswerViewModel {
    let exchangeRateMoney: ExchangeRateMoney?
    let perDollar: Int?
    
    let exchangeRateFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal //천 단위 콤마(,)
        formatter.maximumFractionDigits = 2 // 최대 소수점 단위
        return formatter
    }()
    
    let nowDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
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
        guard let money = exchangeRateMoney?.quotes.USDPHP else { return "국가를 선택해 주세요." }
        return (exchangeRateFormatter.string(from: money as NSNumber) ?? "") + " PHP / USD"
    }
    
    var exchangeRateUSDJPY: String {
        guard let money = exchangeRateMoney?.quotes.USDJPY else { return "국가를 선택해 주세요." }
        return (exchangeRateFormatter.string(from: money as NSNumber) ?? "") + " JPY / USD"
    }
    
    var exchangeRateUSDKRW: String {
        guard let money = exchangeRateMoney?.quotes.USDKRW else { return "국가를 선택해 주세요." }
        return (exchangeRateFormatter.string(from: money as NSNumber) ?? "") + " KRW / USD"
    }
    
    var nowDate: String {
        return nowDateFormatter.string(from: Date())
    }
    
    var exchangeRateChangeUSDPHP: String {
        guard perDollar != 0 else { return "송금액을 입력해 주세요." }
        guard perDollar! < 10000 else { return "송금액이 바르지 않습니다" }
        guard let moneyPHP = exchangeRateMoney?.quotes.USDPHP else { return "국가를 선택해 주세요." }
        let money = moneyPHP * Double(perDollar ?? 0)
        return "수취금액은 " + exchangeRateMoneyFinal(money: money) + " PHP 입니다."
    }
    
    var exchangeRateChangeUSDJPY: String {
        guard perDollar != 0 else { return "송금액을 입력해 주세요." }
        guard perDollar! < 10000 else { return "송금액이 바르지 않습니다" }
        guard let moneyJPY = exchangeRateMoney?.quotes.USDJPY else { return "국가를 선택해 주세요." }
        let money = moneyJPY * Double(perDollar ?? 0)
        return "수취금액은 " + exchangeRateMoneyFinal(money: money) + " JPY 입니다."
    }
    
    var exchangeRateChangeUSDKRW: String {
        guard perDollar != 0 else { return "송금액을 입력해 주세요." }
        guard perDollar! < 10000 else { return "송금액이 바르지 않습니다" }
        guard let moneyKRW = exchangeRateMoney?.quotes.USDKRW else { return "국가를 선택해 주세요." }
        let money = moneyKRW * Double(perDollar ?? 0)
        return "수취금액은 " + exchangeRateMoneyFinal(money: money) + " KRW 입니다."
    }
}
