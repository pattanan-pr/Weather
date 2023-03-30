//
//  WeatherManager.swift
//  Clima
//
//  Created by Pattanan Prarom on 29/3/2566 BE.
//  Copyright © 2566 BE App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateView(_ weatherManager: Weathermanager, weather: WeatherModel)
    func didFail(error: Error)
}

struct Weathermanager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=3a17de987e3d08b15d6eebd25e005912&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlstr = "\(weatherUrl)&q=\(cityName)"
        performrequest(urlstr: urlstr)
    }
    
    func performrequest(urlstr: String) {
        if let url = URL(string: urlstr) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.didFail(error: error!)
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateView(self, weather: weather)
                        //                        let weatherViewCont = WeatherViewController()
                        //                        weatherViewCont.didUpdateView(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(weatherid: id, cityName: name, temperature: temp)
            
            print(weather.toOneDecimal)
            return weather
        }catch{
            delegate?.didFail(error: error)
            return nil
        }
    }
    
}

