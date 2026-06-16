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
                        .font(.title2)
                    HStack{
                        Text(String(weather.main.temp
                            .rounded()
                            .formatted()))
                        Text("°")
                    }
                    .font(.system(size: 100))
                    .scaledToFit()
                        
                    Text(weather.mainDescription?.main ?? "")
                        .font(.title)
                        .foregroundColor(.gray)
                    HStack{
                        Text("Minimum")
                        Text(String(weather.main.tempMin
                            .rounded()
                            .formatted()))
                        Text("°")

                        Text("Maximum")
                        Text(String(weather.main.tempMax
                            .rounded()
                            .formatted()))
                        Text("°")
                    }
                    .font(.title2)
                    
                    Text(weather.description?.description.description ?? ""
                        .capitalized)
                    //revisar como cambiar este texto a mayusculas
                        .padding(.top,10)
                }
                .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.colorBackground)
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
}

#Preview {
    WeatherDetailView(name: "Popayan")
}
