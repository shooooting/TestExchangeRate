//
//  CalculationButton.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/08.
//

import UIKit

class CalculationButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        setTitle("환율 계산하기", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
