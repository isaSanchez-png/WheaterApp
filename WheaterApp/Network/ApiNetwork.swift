//
//  ApiNetwork.swift
//  WheaterApp
//
//  Created by Isa on 15/06/26.
//
import Foundation

class ApiNetwork {
    struct WeatherComplete: Codable {
        let name: String
        let weather: [Weather]
        let main: MainWeather
        let sys: SysWeather
        let dt: Int
        let timezone: Int
        
        var realHour: Date {
            return Date(timeIntervalSince1970: Double(dt))
        }
        
        var mainDescription: Weather? {
            return weather.first
        }
        var description: Weather? {
            return weather.last
        }
        
        var isNight: Bool {
            dt < sys.sunrise || dt > sys.sunset
        }
    }
    
    struct Weather: Codable {
        let main: String
        let description: String
    }
    
    struct MainWeather: Codable {
        let temp: Float
        let tempMin: Float
        let tempMax: Float
        let pressure: Int
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp = "temp"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure  = "pressure"
            case humidity = "humidity"
        }
    }
    
    struct SysWeather: Codable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
    func getWheaterByCity(nameCity: String) async throws -> WeatherComplete {
        let url = URL(string:
                        "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity)&appid=274879dc19630a086ee40e1ac5d25d27&units=metric&lang=en")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let weatherData = try JSONDecoder().decode(ApiNetwork.WeatherComplete.self, from: data)
        
        return weatherData
    }
    
    func getWeatherByCoordinate(latitude: Double, longitude: Double) async throws -> WeatherComplete {
        let url = URL(string:
                        "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=274879dc19630a086ee40e1ac5d25d27&units=metric&lang=en")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let weatherDataLocation = try
        
        JSONDecoder().decode(ApiNetwork.WeatherComplete.self, from: data)
        
        return weatherDataLocation
    }
}
