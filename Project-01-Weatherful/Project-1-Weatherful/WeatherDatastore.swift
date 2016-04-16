//
//  WeatherDatastore.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/29/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherDatastore {
    // API Key
    let APIKey = "130be06806b8c006e0016caf4880b174"
    
    func retrieveCurrentWeatherAtLat(lat: CLLocationDegrees, lon: CLLocationDegrees, block: (weatherCondition: WeatherCondition) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/weather?APPID=\(APIKey)"
        let params = ["lat": lat, "lon": lon]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { response in
            
            switch response.result {
                
            case .Success(let json):
                let json = JSON(json)
                block(weatherCondition: self.createWeatherConditionFromJson(json))
                
            case .Failure(let error):
                print("failed to get weather data: \(error)")
            }
        }
    }
    
    func retrieveHourlyForecastAtLat(lat: CLLocationDegrees, lon: CLLocationDegrees, block: (weatherConditions: [WeatherCondition]) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?APPID=\(APIKey)"
        let params = ["lat": lat, "lon": lon]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { response in
        
            switch response.result {
            case .Success(let json):
                print(json)
                let json = JSON(json)
                let list: [JSON] = json["list"].arrayValue
                
                let weatherConditions: [WeatherCondition] = list.map() {
                    return self.createWeatherConditionFromJson($0)
                }
                block(weatherConditions: weatherConditions)
                
            case .Failure(let error):
                print("failed to get json response: \(error)")
            }
            
        
        }
        
    }
    
    func retrieveDailyForecastAtLat(lat: Double, lon: Double, dayCount: Int, block: (weatherConditions: [WeatherCondition]) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?APPID=\(APIKey)"
        let parms = ["lat": lat, "lon": lon, "cnt":Double(dayCount+1)]
        
        Alamofire.request(.GET, url, parameters: parms).responseJSON { response in
            
            switch response.result {
            case .Success(let json):
                print(json)
                let json = JSON(json)
                let list: [JSON] = json["list"].arrayValue
                let weatherConditions: [WeatherCondition] = list.map() {
                    return self.createDayForecastFromJson($0)
                }
                let count = weatherConditions.count
                let daysWithoutToday = Array(weatherConditions[1..<count])
                block(weatherConditions: daysWithoutToday)
            case .Failure(let error):
                print("Failed to get json response: \(error)")
            }
        }
        
    }

    
}

private extension WeatherDatastore {
    
    func createWeatherConditionFromJson(json: JSON) -> WeatherCondition {
        let name = json["name"].string
        let weather = json["weather"][0]["main"].stringValue
        let icon = json["weather"][0]["icon"].stringValue
        let dt = json["dt"].doubleValue
        let time = NSDate(timeIntervalSinceReferenceDate: dt)
        let tempKelvin = json["main"]["temp"].doubleValue
        let maxTempKelvin = json["main"]["temp_max"].doubleValue
        let minTempKelvin = json["main"]["temp_min"].doubleValue
        
        return WeatherCondition(
            cityName: name,
            weather: weather,
            icon: IconType(rawValue: icon),
            time: time,
            tempKelvin: tempKelvin,
            maxTempKelvin: maxTempKelvin,
            minTempKelvin: minTempKelvin
        )
    }
    
    func createDayForecastFromJson(json: JSON) -> WeatherCondition {
        let name = ""
        let weather = json["weather"][0]["main"].stringValue
        let icon = json["weather"][0]["icon"].stringValue
        let dt = json["dt" ].doubleValue
        let time = NSDate(timeIntervalSince1970: dt)
        let tempKelvin = json["temp"]["day"].doubleValue
        let maxTempKelvin = json["temp"]["max"].doubleValue
        let minTempKelvin = json["temp"]["min"].doubleValue
        
        return WeatherCondition(
            cityName: name,
            weather: weather,
            icon: IconType(rawValue: icon),
            time: time,
            tempKelvin: tempKelvin,
            maxTempKelvin: maxTempKelvin,
            minTempKelvin: minTempKelvin
        )
    }
}