//
//  Extension.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import UIKit

extension UIView {
    
    func dateFormatter() -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter
        }()
        
        return dateFormatter.string(from: Date())
    }
}

extension UITextField {
    func addRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}

