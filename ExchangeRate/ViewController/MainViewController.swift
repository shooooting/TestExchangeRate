//
//  ViewController.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/06.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func exchangeRateMoney(_ data: ExchangeRateMoney)
}

class MainViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: MainViewControllerDelegate?
    private var data: ExchangeRateMoney? {
        didSet {
            self.delegate = answerView
            guard let data = self.data else { return }
            delegate?.exchangeRateMoney(data)
        }
    }
    
    private var error: Error? {
        didSet { guard error == nil else { return errorMessage() } } // 환율 데이터를 가져올 때 Err가 나면 출력
    }
    
    private var money = "" { // 송금액
        didSet { warningAction() }
    }
    
    private let titleLabel = MainTitleLabel() // 환율 계산 제목
    private let listView = MainListView() // 왼쪽 리스트
    private let remittanceUSA = UILabel() // 송금국가 :미국 (USD)
    private let answerView = MainAnswerView()
    
    private let warning = WarningView(title: "") // 팝업 뷰
    private var topConstraint: NSLayoutConstraint? // 팝업 뷰 애니메이션
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true) // 화면을 터치했을때 숫자패드나 피커가 내려감
    }
    
    private func errorMessage() { // API데이터 가져올 때 Err 나오면 Alert띄우기
        let actionSheet = UIAlertController(title: "Error",
                                            message: "환율 데이터를 가져오는데 오류가 생겼습니다.",
                                            preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "확인",
                                            style: .cancel,
                                            handler: nil))
        self.present(actionSheet, animated: true)
    }
}

// MARK: - API
extension MainViewController {
    private func setExchangeRateAPI() {
        Service.exchangeRate { data, error  in
            self.data = data
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
}

// MARK: - UI
extension MainViewController {
    private func setUI() {
        view.backgroundColor = .white
        [titleLabel, listView, answerView, warning].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            listView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            answerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            answerView.leadingAnchor.constraint(equalTo: listView.trailingAnchor, constant: 10),
            
            warning.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warning.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            warning.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            warning.heightAnchor.constraint(equalToConstant: 60)
        ])
        topConstraint = warning.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -130)
        topConstraint?.isActive = true
        
        answerView.delegate = self
    }
}

// MARK: - Action
extension MainViewController {
    private func warningPopUpString() {
        warning.setText(text: "송금액이 바르지 않습니다")
        animateWarning()
        self.view.endEditing(true)
    }
    
    private func warningAction() {
        guard money != "" else { return }
        guard let perDollar: Int = Int(money) else { return warningPopUpString() }
        guard perDollar > 0 && perDollar < 10000 else { return warningPopUpString() }
    }
    
    private func animateWarning() { // Popup animate
        warning.isHidden = false
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            animations: {
                self.topConstraint?.constant = 50
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(
                    withDuration: 0.4,
                    delay: 1.5,
                    animations: {
                        self.topConstraint?.constant = -130
                        self.view.layoutIfNeeded()
                    }, completion: { _ in return self.warning.isHidden = true })
            })
    }
}

// MARK: - MainAnswerViewDelegate
extension MainViewController: MainAnswerViewDelegate {
    func answer(_ answerView: MainAnswerView, pickerRow: String?, money: String?) {
        self.money = money ?? ""
        if pickerRow != "" {
            setExchangeRateAPI()
        }
    }
}

