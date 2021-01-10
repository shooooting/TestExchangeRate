//
//  Service.swift
//  ExchangeRate
//
//  Created by ㅇ오ㅇ on 2021/01/06.
//

import UIKit

class Service {
    
    static func exchangeRate(completion: @escaping (ExchangeRateMoney?, Error?) -> Void) {
        
        let query = "http://api.currencylayer.com/live?access_key=d48346a629698fbb5f31518da905e899"
        guard let queryURL = URL(string: query) else { return }
        let requestURL = URLRequest(url: queryURL)
        

        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            guard error == nil else { return print("error")}
            guard let data = data else { return print("data")}
            
            do {
                let data = try JSONDecoder().decode(ExchangeRateMoney.self, from: data)
                completion(data, nil)
            } catch {
                print("DEBUG: exchangeRateService ERROR \(error)")
                completion(nil, error)
            }
        }
        task.resume()
        
    }
}
