//
//  RecipientMoneyView.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/09.
//

import UIKit

class RecipientMoneyView: UILabel {
    
    private var data: ExchangeRateMoney? {
        didSet { configure() }
    }
    private var perDollar: Int?
    private var country: String?
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let data = self.data else { return }
        guard let perDollar = self.perDollar else { return }
        let viewModel = RecipientMoneyViewModel(exchangeRateMoney: data, perDollar: perDollar)
        
        if self.country == "필리핀 (PHP)" {
            text = viewModel.exchangeRateUSDPHP
        } else if self.country == "한국 (KRW)" {
            text = viewModel.exchangeRateUSDKRW
        } else {
            text = viewModel.exchangeRateUSDJPY
        }
    }
}

//extension RecipientMoneyView: MainViewControllerRecipientMoneyDelegate {
//    func recipientMoney(_ data: ExchangeRateMoney, country: String, perDollar: Int) {
//        self.data = data
//        self.country = country
//        self.perDollar = perDollar
//        print("B")
//    }
//}
