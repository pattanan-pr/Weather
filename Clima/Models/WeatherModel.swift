//
//  WeatherModel.swift
//  Clima
//
//  Created by Pattanan Prarom on 31/3/2566 BE.
//  Copyright © 2566 BE App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let weatherid: Int
    let cityName: String
    let temperature: Double
    
    var toOneDecimal: String{
        String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch weatherid{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
