//
//  BitcoinViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 11/2/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class BitcoinViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    
    //MARK: - Declaration of base URL and Currency Strings to populate pickerview
    let baseURL = "https://blockchain.info/ticker"
    let currencyArray = [ "USD",
                          "AUD",
                          "BRL",
                          "CAD",
                          "CHF",
                          "CLP",
                          "CNY",
                          "DKK",
                          "EUR",
                          "GBP",
                          "HKD",
                          "INR",
                          "ISK",
                          "JPY",
                          "KRW",
                          "NZD",
                          "PLN",
                          "RUB",
                          "SEK",
                          "SGD",
                          "THB",
                          "TRY",
                          "TWD"]
 
    //IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var sindex = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self

    }
    
    
    //MARK: - UIPickerView Delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getBitcoinPrice(url: baseURL)
        //take selected currency
        sindex = currencyArray[row]
    }
    
    //MARK: - Networking
    
    func getBitcoinPrice(url: String) {
        //Conenct to the API and get all data
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the bitcion price data")
                    let bitcoinPriceJson : JSON = JSON(response.result.value!)
                    //send JSON to function to extract specific data
                    
                    self.updateBitcoinPriceData(json: bitcoinPriceJson)
                    
                } else {
                    //Connection Failed No data Extracted
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
                
          
        }
    }
    
    
    //MARK: - JSON Parsing to extract value and symbol of selected bitcoin currency
    
    func updateBitcoinPriceData(json : JSON) {
        
        if let btcPriceResult = json[sindex]["last"].double {
            let btcSymbol = json[sindex]["symbol"].string
            DispatchQueue.main.async {
                self.bitcoinPriceLabel.text = "\(btcSymbol!) \(Double(btcPriceResult))"
            }
            
           print (btcSymbol!)
        } else {
            DispatchQueue.main.async {
                self.bitcoinPriceLabel.text = "Price Unavailable"
            }
            
        }
    }

    
    
    
    
    
}
