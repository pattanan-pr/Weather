//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weathermanager = Weathermanager()
    let localLocation = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localLocation.requestWhenInUseAuthorization()
        localLocation.delegate = self
        localLocation.requestLocation()
        searchTextField.delegate = self
        weathermanager.delegate = self
    }
    
    @IBAction func locallocationPressed(_ sender: UIButton) {
        localLocation.requestLocation()
    }
}

extension WeatherViewController: UITextFieldDelegate{
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
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateView(_ weatherManager: Weathermanager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.toOneDecimal
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
    }
    func didFail(error: Error) {
        print("Something went wrong!")
    }
}


extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            localLocation.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weathermanager.fetchWeather(latitude: lat, longitute: lon)
            print(lat)
            print(lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
