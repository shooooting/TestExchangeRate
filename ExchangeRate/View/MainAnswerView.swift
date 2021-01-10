//
//  MainAnswerView.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/08.
//

import UIKit

protocol MainAnswerViewDelegate: class {
    func answer(_ answerView: MainAnswerView, pickerRow: String?, money: String?)
//    func answer(_ answerView: MainAnswerView)
//    func remittanceDomainMoney(_ money: String)
}

class MainAnswerView: UIView {
    
    // MARK: - Properties
    weak var delegate: MainAnswerViewDelegate?
    var remittanceDomainMoney = 0 {
        didSet { configure() }
    }
    private var data: ExchangeRateMoney? {
        didSet { configure() }
    }
    
    private let remittanceUSA = UILabel() // 송금국가 :미국 (USD)
    
    let recipientCountryField = UITextField() // 버튼을 눌러 수취 국가를 변경 default 한국(KWS)
    let RecipientCountryData = ["한국 (KRW)", "일본 (JPY)", "필리핀 (PHP)"] // 수취 국가들
    let RecipientCountryPickerView = UIPickerView() // 국가 선택 Picker View
    
    private let dollarExchangeRateField = UILabel()// 1USD 기준으로 각 수취국가별 금액
    
    private let dateLabel = UILabel() // 조회시간 yyyy-MM-dd HH-mm
    
    let remittanceDomain = RemittanceField() // 송금액을 적는 부분
    
    let recipientMoney = UILabel() // 환율 계산해서 결과값 출력되는 부분
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        
        setUI()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Action
extension MainAnswerView {
    private func setAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                               name: UITextField.textDidChangeNotification, object: nil)
    }
    
    @objc
    private func handleTextInputChange() {
        guard let money = remittanceDomain.text else { return print("A")}
        remittanceDomainMoney = Int(remittanceDomain.text ?? "0") ?? 0
        delegate?.answer(self, pickerRow: "", money: money)
    }
}

// MARK: - configure
extension MainAnswerView {
    private func configure() {
        let viewModel = MainAnswerViewModel(exchangeRateMoney: data, perDollar: remittanceDomainMoney)
        
        DispatchQueue.main.async {
            let row = self.RecipientCountryPickerView.selectedRow(inComponent: 0)
            if self.RecipientCountryData[row] == "필리핀 (PHP)" {
                self.dollarExchangeRateField.text = viewModel.exchangeRateUSDPHP
                self.recipientMoney.text = viewModel.exchangeRateChangeUSDPHP
            } else if self.RecipientCountryData[row] == "한국 (KRW)" {
                self.dollarExchangeRateField.text = viewModel.exchangeRateUSDKRW
                self.recipientMoney.text = viewModel.exchangeRateChangeUSDKRW
            } else {
                self.dollarExchangeRateField.text = viewModel.exchangeRateUSDJPY
                self.recipientMoney.text = viewModel.exchangeRateChangeUSDJPY
            }
            self.dateLabel.text = viewModel.nowDate
        }
    }
}

// MARK: - UIPickerViewDataSource
extension MainAnswerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RecipientCountryData.count
    }
}

// MARK: - UIPickerViewDelegate
extension MainAnswerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RecipientCountryData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recipientCountryField.text  = RecipientCountryData[row]
        recipientCountryField.resignFirstResponder()
        delegate?.answer(self, pickerRow: RecipientCountryData[row], money: "")
    }
}

// MARK: -  MainViewControllerDelegate
extension MainAnswerView: MainViewControllerDelegate {
    func exchangeRateMoney(_ data: ExchangeRateMoney) {
        self.data = data
    }
    
}

// MARK: - setUI
extension MainAnswerView {
    private func setUI() {
        backgroundColor = .white
        let resultStack = UIStackView(arrangedSubviews: [remittanceUSA, recipientCountryField,
                                                         dollarExchangeRateField, dateLabel, remittanceDomain])
        resultStack.axis = .vertical
        resultStack.spacing = 16
        resultStack.alignment = .leading
        
        addSubview(resultStack)
        addSubview(recipientMoney)
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        remittanceDomain.translatesAutoresizingMaskIntoConstraints = false
        recipientMoney.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultStack.topAnchor.constraint(equalTo: topAnchor),
            resultStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            resultStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            resultStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            remittanceDomain.widthAnchor.constraint(equalToConstant: 100),
            remittanceDomain.heightAnchor.constraint(equalToConstant: 25),
            
            recipientMoney.topAnchor.constraint(equalTo: resultStack.bottomAnchor, constant: 20),
            recipientMoney.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
        ])
        
        remittanceUSA.text = "미국 (USD)"
        recipientCountryField.text = "국가를 선택해 주세요."
        dollarExchangeRateField.text = "0 KRW / USD"
        recipientMoney.text = "수취 국가와 송금액을 입력해 주세요."
        
        dateLabel.text = dateFormatter()
        recipientCountryField.inputView = RecipientCountryPickerView
        
        RecipientCountryPickerView.backgroundColor = .white
        RecipientCountryPickerView.dataSource = self
        RecipientCountryPickerView.delegate = self
    }
}
