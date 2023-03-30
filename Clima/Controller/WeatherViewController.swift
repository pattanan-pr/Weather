//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weathermanager = Weathermanager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weathermanager.delegate = self
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "You should enter something!"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityname = searchTextField.text{
            weathermanager.fetchWeather(cityName: cityname)
        }
        searchTextField.text = ""
    }
    func didUpdateView(_ weatherManager: Weathermanager, weather: WeatherModel){
        print(weather.temperature)
    }
    func didFail(error: Error) {
        print("Something went wrong!")
    }
}

