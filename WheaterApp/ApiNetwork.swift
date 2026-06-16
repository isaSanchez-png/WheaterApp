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
        
        var mainDescription: Weather? {
            return weather.first
        }
        var description: Weather? {
            return weather.last
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
        
        enum CodingKeys: String, CodingKey {
            case temp = "temp"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    func getWheaterByCity(nameCity: String) async throws -> WeatherComplete {
        let url = URL(string:
                        "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity)&appid=274879dc19630a086ee40e1ac5d25d27&units=metric")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let weatherData = try JSONDecoder().decode(ApiNetwork.WeatherComplete.self, from: data)
        
        return weatherData
    }
}
