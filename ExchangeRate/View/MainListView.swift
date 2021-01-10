//
//  MainView.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import UIKit

class MainListView: UIView {
    
    // MARK: - Properties
    private let RemittanceCountryLabel = ExchangeRateTitleLabel(name: "송금국가 :")// 송금국가:
    private let RecipientCountryTitleLabel = ExchangeRateTitleLabel(name: "수취국가 :") // 수취국가:
    private let exchangeRateLabel = ExchangeRateTitleLabel(name: "환율 :") // 환율:
    private let nowTimeTitleLabel = ExchangeRateTitleLabel(name: "조회시간 :") // 조회시간:
    private let remittanceLabel = ExchangeRateTitleLabel(name: "송금액 :") // 송금액:
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .white
        let titleStack = UIStackView(arrangedSubviews: [RemittanceCountryLabel, RecipientCountryTitleLabel, exchangeRateLabel, nowTimeTitleLabel, remittanceLabel])
        
        titleStack.axis = .vertical
        titleStack.spacing = 16
        titleStack.alignment = .trailing
        
        addSubview(titleStack)
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: topAnchor),
            titleStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
