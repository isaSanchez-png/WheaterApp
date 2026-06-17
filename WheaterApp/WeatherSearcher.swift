//
//  ContentView.swift
//  WheaterApp
//
//  Created by Isa on 15/06/26.
//

import SwiftUI

struct WeatherSearcher: View {
    @State var cityName: String = ""
    @State var wrapper: ApiNetwork.WeatherComplete? = nil
    @State var showSheet: Bool = false
    @State var favoriteCities: [String] = []
    
    var body: some View {
        VStack {
            Text("Weather")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            VStack {
                ZStack {
                    Rectangle()
                    HStack{
                        Image(systemName: "location.fill")
                            .foregroundColor(.white)
                        Text("City with ubication")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                //ForEach(cityName)
                //}
                
                
            }
            .cornerRadius(16)
            .frame(maxWidth: .infinity, maxHeight: 150)
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(.white.opacity(0.7))
                    
                    TextField("", text: $cityName, prompt: Text("Search a city")
                        .foregroundColor(.white.opacity(0.7)))
                    .font(.title2)
                    .autocorrectionDisabled()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .onSubmit {
                        Task {
                            do {
                                wrapper = try await ApiNetwork().getWheaterByCity(nameCity: cityName)
                                showSheet = true
                            } catch {
                                print ("Error\(error)")
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                
            }
            .cornerRadius(16)
            .frame(maxWidth: .infinity, maxHeight: 80)
            
        }
        .padding()
        .background(.colorBackground)
        
        .sheet(isPresented: $showSheet){
            VStack {
                HStack (spacing: 250){
                    Button(action: {
                        withAnimation{
                            showSheet = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(.gray .opacity(0.3))
                    })
                    Button(action: {
                        withAnimation{
                            favoriteCities.insert(cityName, at: 0)
                                showSheet = false
                            print(favoriteCities)
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(.gray .opacity(0.3))
                    })
                }
                .padding(.top, 16)
                WeatherDetailView(name: cityName)
            }
            .background(Color.colorBackground)
        }
    }
    
    struct weatherItem: View {
        let cityName: ApiNetwork.Weather
        
        var body: some View {
            ZStack{
                Text("hello")
            }
        }
    }

}

#Preview {
    WeatherSearcher()
}
