//
//  WarningView.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/07.
//

import UIKit

class WarningView: UIView {

    // MARK: - Properties
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        self.title.text = title
        self.isHidden = true
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .black
    }

    private func setConstraints() {
        
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Helpers
    func setText(text: String) {
        title.text = text
    }
}

