//
//  ExchangeRateTests.swift
//  ExchangeRateTests
//
//  Created by ㅇ오ㅇ on 2021/01/08.
//

import XCTest
@testable import ExchangeRate

class ExchangeRateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainAnswerViewModel() throws {
        // 뷰모델에 들어가는 값에 대해서 확인하였다.
        let quotes = Quotes(USDKRW: 1093.01, USDJPY: 103.94, USDPHP: 48.05)
        let exchangeRateMoney = ExchangeRateMoney(quotes: quotes)
        let mainAnswerViewModel = MainAnswerViewModel(exchangeRateMoney: exchangeRateMoney,
                                                      perDollar: 2)
        
        XCTAssertEqual(mainAnswerViewModel.exchangeRateChangeUSDPHP,
                       "송금액을 입력해 주세요.")
        
        XCTAssertEqual(mainAnswerViewModel.exchangeRateChangeUSDPHP,
                       "수취금액은 48.05 PHP 입니다.")
        
        XCTAssertEqual(mainAnswerViewModel.exchangeRateChangeUSDPHP,
                       "수취금액은 96.1 PHP 입니다.")
    }
}
