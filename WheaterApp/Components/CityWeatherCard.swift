//
//  CityWeatherCard.swift
//  WheaterApp
//
//  Created by Isa on 17/06/26.
//

import SwiftUI

struct CityWeatherCard: View {
    let cityName: String
    @State var weather: ApiNetwork.WeatherComplete? = nil
    
    var body: some View {
        ZStack {
            if let weather = weather {
                VStack {
                    HStack(alignment: .center){
                        VStack (alignment: .leading, spacing: 4){
                            Text(weather.name)
                                .font(.title2)
                                .bold()
                                .shadow(radius: 12)
                            
                            Text(formatLocalTime(dt: weather.realHour, timeZoneOff: weather.timezone))
                                .shadow(radius: 12)
                                .bold()
                                .padding(.bottom, 4)
                            Text(weather.mainDescription?.main ?? "")
                                .shadow(radius: 12)
                                .font(.title3)
                                .italic()
                                .bold()
                        }
                        Spacer()
                        
                        HStack (spacing: 2){
                            Text(String(weather.main.temp
                                .rounded()
                                .formatted()))
                            Image(systemName: "degreesign.celsius")
                        }
                        .font(.system(size: 50))
                    }
                    .shadow(radius: 12)
                    
                    Spacer()
                    
                    HStack{
                        HStack {
                            Text("Minimun: \(String(weather.main.tempMin.rounded().formatted()))°")
                            Text("Maximun: \(String(weather.main.tempMax.rounded().formatted()))°")
                        }
                        .font(.subheadline)
                        .shadow(radius: 12)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .background(getBackground(for: weather.mainDescription?.main ?? "clear", isNight: weather.isNight))
                .cornerRadius(16)
            } else {
                ProgressView()
                    .tint(.white)
                    .frame(minWidth: .infinity)
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 120)
        .onAppear{
            Task{
                do {
                    weather = try await ApiNetwork().getWheaterByCity(nameCity: cityName)
                } catch {
                    print("Error \(error)")
                }
            }
        }
    }
    func getBackground(for condition :String, isNight: Bool) -> LinearGradient {
        switch condition.lowercased() {
        case "clear":
            if isNight {
                return LinearGradient(colors: [Color(red: 0.05, green: 0.05, blue: 0.15), .black], startPoint: .top, endPoint: .bottom)
            } else {
                return LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
            }
        case "clouds":
            if isNight {
                return LinearGradient(colors: [.init(white: 0.1), Color(red: 0.1, green: 0.1, blue: 0.2)], startPoint: .top, endPoint: .bottom)
            }
            else {
                return LinearGradient(colors: [.gray, .blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
            }
        case "rain", "drizzle", "thunderstorm":
            if isNight {
                return LinearGradient(colors: [.black, .init(white: 0.08)], startPoint: .top, endPoint: .bottom)
            } else {
                return LinearGradient(colors: [.init(white: 0.2), .gray], startPoint: .top, endPoint: .bottom)
            }
        default:
            return
            if isNight {
                LinearGradient(colors: [.black, .purple.opacity(0.2)], startPoint: .top, endPoint: .bottom)
            } else {
                LinearGradient(colors: [.black, .purple.opacity(0.2)], startPoint: .top, endPoint: .bottom)
            }
        }
    }
    func formatLocalTime(dt: Date, timeZoneOff: Int) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        formatter.timeZone = TimeZone(secondsFromGMT: timeZoneOff)
        return formatter.string(from: dt)
    }
}

#Preview {
    CityWeatherCard(cityName: "Cali")
}
