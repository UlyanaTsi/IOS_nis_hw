//
//  ViewController.swift
//  Securities
//
//  Created by Ульяна Цимбалистая on 11.12.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var compNameLabel: UILabel!
    @IBOutlet weak var companyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var compSymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    private let companies : [String: String] = ["Apple" : "AAPL",
                                                "Microsoft" : "MSFT",
                                                "Google" : "GOOG",
                                                "Amazon" : "AMZN",
                                                "Facebook" : "FB"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.companyPickerView.dataSource = self
        self.companyPickerView.delegate = self
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.requestQuoteUpdate()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.companies.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(self.companies.keys)[row]
    }
    
    private func requestQuote(for symbol: String){
        let url = URL(string: "https://nosecurityshares.azurewebsites.net/Stonks/\(symbol)")!
        
        let dataTask = URLSession.shared.dataTask(with: url) {data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
                else{
                    print("Ошибка соединения")
                    return
                }
            self.parseQuote(data: data)
        }
        
        dataTask.resume()
    }
    
    private func parseQuote(data: Data){
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double
            else {
                print("Неверный формат JSON объекта")
                return
            }
            DispatchQueue.main.async {
                self.displayStockInfo(companyName: companyName, symbol: companySymbol, price: price, priceChange: priceChange)
            }
        } catch {
            print("Ошибка:" + error.localizedDescription)
        }
    }
    
    private func displayStockInfo(companyName: String, symbol: String, price: Double, priceChange: Double){
        self.activityIndicator.stopAnimating()
        self.compNameLabel.text = companyName
        self.compSymbolLabel.text = symbol
        self.priceLabel.text = "\(price)$"
        self.priceChangeLabel.text = "\(priceChange)$"
    }
    
    private func requestQuoteUpdate(){
        self.activityIndicator.startAnimating()
        self.compNameLabel.text = "-"
        self.compSymbolLabel.text = "-"
        self.priceLabel.text = "-"
        self.priceChangeLabel.text = "-"
        
        let selectedRow = self.companyPickerView.selectedRow(inComponent: 0)
        let selectedSymbol = Array(self.companies.values)[selectedRow]
        self.requestQuote(for: selectedSymbol)

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.requestQuoteUpdate()
    }
}
