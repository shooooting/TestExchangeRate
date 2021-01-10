//
//  MainTitleLabel.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import UIKit

class MainTitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        text = "환율 계산"
        font = UIFont.systemFont(ofSize: 50)
        textAlignment = .center
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
