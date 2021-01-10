//
//  remittanceField.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import UIKit

class RemittanceField: UITextField {
    
    init() {
        super.init(frame: .zero)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        keyboardType = .numberPad
        textAlignment = .right
        addRightPadding()
        
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 18)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
