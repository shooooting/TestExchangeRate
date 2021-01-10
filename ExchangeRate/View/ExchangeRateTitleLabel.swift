//
//  LabelView.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/06.
//

import UIKit

class ExchangeRateTitleLabel: UILabel {
    
    init(name: String) {
        super.init(frame: .zero)
        
        text = name
        font = UIFont.systemFont(ofSize: 18)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
