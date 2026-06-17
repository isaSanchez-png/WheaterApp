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
    
    var body: some View {
        VStack{
            if loading {
                ProgressView()
                    .tint(.white)
                    .scaleEffect()
                
            } else if let weather = weather {
                VStack{
                    Text(weather.name)
                        .font(.largeTitle)
                        .autocapitalization(.allCharacters)
                    Text(weather.realHour.formatted(date: .complete, time:.shortened))
                    
                    HStack{
                        Text(String(weather.main.temp
                            .rounded()
                            .formatted()))
                        Image(systemName: "degreesign.celsius")
                    }
                    .font(.system(size: 120))
                    .scaledToFit()
                    
                    HStack {
                        Text(weather.mainDescription?.main ?? "")
                        Text(weather.mainDescription?.description ?? "")
                    }
                    .font(.title3)
                    .foregroundColor(.gray)
                    .italic()
                    .padding(.bottom, 2)
                    
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
                                    .foregroundColor(.gray.opacity(0.1))
                                VStack{
                                    HStack{
                                        Image(systemName: "humidity.fill")
                                            .bold()
                                            .scaledToFit()
                                        Text("Humidity")
                                            .font(.title2)
                                            .bold()
                                    }
                                    .foregroundColor(.gray)
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
                                    .foregroundColor(.gray.opacity(0.1))
                                VStack{
                                    HStack{
                                        Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                                            .bold()
                                            .scaledToFit()
                                        Text("Pressure")
                                            .font(.title2)
                                            .bold()
                                        
                                    }
                                    .foregroundColor(.gray)
                                    
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
                    if weather.realHour > Date.now {
                        Text(Date.now.formatted(date: .complete, time: .shortened))
                    }
                }
                .padding(.top,10)
                .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getBackground(for: weather?.mainDescription?.main ?? ""))
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
    func getBackground(for condition :String) -> LinearGradient {
        switch condition.lowercased() {
        case "clear":
            return LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
        case "clouds":
            return LinearGradient(colors: [.gray, .blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
        case "rain", "drizzle", "thunderstorm":
            return LinearGradient(colors: [.init(white: 0.2), .gray], startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(colors: [.colorBackground, .blue], startPoint: .top, endPoint: .bottom)
        }
    }
}


#Preview {
    WeatherDetailView(name: "Cali")
}
