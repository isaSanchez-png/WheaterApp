//
//  WeatherDetail.swift
//  WheaterApp
//
//  Created by Isa on 15/06/26.
//

import SwiftUI

struct WeatherDetailView: View {
    let name: String
    @State var weather: ApiNetwork.WeatherComplete? = nil
    @State var loading: Bool = false    
    var showActiveButtons: Bool = true
    
    var body: some View {
        VStack{
            if loading {
                ProgressView()
                    .tint(.white)
                    .scaleEffect()
                
            } else if let weather = weather {
                VStack{
                    Text(weather.name)
                        .font(.system(size: 40))
                        .autocapitalization(.allCharacters)
                    Text(formatLocalTime(dt: weather.realHour, timeZoneOff: weather.timezone))
                    
                    
                    HStack{
                        Text(String(weather.main.temp
                            .rounded()
                            .formatted()))
                        Image(systemName: "degreesign.celsius")
                    }
                    .font(.system(size: 120))
                    .scaledToFit()
                    .shadow(radius: 8)
                    
                    HStack {
                        Text(weather.mainDescription?.main ?? "")
                        Text(weather.mainDescription?.description ?? "")
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .italic()
                    .bold()
                    .padding(.bottom, 2)
                    .shadow(radius: 10)
                    
                    HStack{
                        Text("Minimum")
                        Text(String(weather.main.tempMin
                            .rounded()
                            .formatted()))
                        Image(systemName: "degreesign.celsius")
                        
                        Text("Maximum")
                        Text(String(weather.main.tempMax
                            .rounded()
                            .formatted()))
                        Image(systemName: "degreesign.celsius")
                    }
                    .font(.title2)
                    
                    HStack{
                        HStack{
                            ZStack(){
                                Rectangle()
                                    .frame(height: 200)
                                    .cornerRadius(24)
                                    .foregroundColor(.gray.opacity(0.2))
                                    .shadow(radius: 10)
                                VStack{
                                    HStack{
                                        Image(systemName: "humidity.fill")
                                            .bold()
                                            .scaledToFit()
                                        Text("Humidity")
                                            .font(.title2)
                                            .bold()
                                    }
                                    .foregroundColor(.white)
                                    HStack{
                                        Text(String(weather.main.humidity))
                                        Text("%")
                                    }
                                    .padding()
                                    .font(.system(size: 40))
                                    .bold()
                                }
                            }
                            ZStack{
                                Rectangle()
                                    .frame(height: 200)
                                    .cornerRadius(24)
                                    .foregroundColor(.gray.opacity(0.2))
                                    .shadow(radius: 10)

                                VStack{
                                    HStack{
                                        Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                                            .bold()
                                            .scaledToFit()
                                        Text("Pressure")
                                            .font(.title2)
                                            .bold()
                                        
                                    }
                                    .foregroundColor(.white)
                                    
                                    HStack{
                                        Text(String(weather.main.pressure))
                                        Text("hPa")
                                            .font(.title3)
                                    }
                                    .padding()
                                    .font(.system(size: 40))
                                    .bold()
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Text("Weather for \(weather.name), \(weather.sys.country)")
                    Text ("Your date and time are:")
                    Text ("\(Text(Date.now.formatted(date: .complete, time: .shortened)))")
                }
                .padding(.top,10)
                .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getBackground(for: weather?.mainDescription?.main ?? "clear", isNight: weather?.isNight ?? true))
        .ignoresSafeArea()
        
        .onAppear{
            Task{
                do {
                    loading = true
                    weather = try await ApiNetwork().getWheaterByCity(nameCity: name)
                } catch {
                    weather = nil
                }
                loading = false
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
        formatter.dateStyle = .long
        
        formatter.timeZone = TimeZone(secondsFromGMT: timeZoneOff)
        return formatter.string(from: dt)
    }
}


#Preview {
    WeatherDetailView(name: "Cali")
}
