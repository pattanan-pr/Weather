//
//  WeatherData.swift
//  Clima
//
//  Created by Pattanan Prarom on 31/3/2566 BE.
//  Copyright © 2566 BE App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable{
    let temp: Double
}
struct Weather: Codable{
    let description: String
    let id: Int
}
