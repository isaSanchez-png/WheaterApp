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
    @StateObject var store = WeatherStore()
    @State var showButtonsSheet: Bool = true
    @StateObject var gps = GPSManager()
    @State private var activeSheetCity: selectedCityIdentifiable? = nil

    var body: some View {
        VStack {
            Text("Weather")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.top, 65)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    if gps.latitude != nil {
                        CurrentLocationCard(location: gps, latitude: gps.latitude ?? 0, longitude: gps.longitude ?? 0)
                            .padding(.top, 10)
                        
                            .onTapGesture {
                                activeSheetCity = selectedCityIdentifiable(name: gps.currentCityName ?? "")
                                showButtonsSheet = false
                                
                            }
                    } else {
                        ProgressView()
                            .tint(.white)
                            .frame(width: 350, height: 120)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(16)
                    }
                    
                    ForEach(store.favoriteCities, id: \.self) { city in
                        CityWeatherCard(cityName: city)
                            .onTapGesture {
                                activeSheetCity = selectedCityIdentifiable(name: city)
                                showButtonsSheet = false
                            }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
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
                    
                    TextField("", text: $cityName, prompt: Text("Search a city").foregroundColor(.white.opacity(0.7)))
                        .font(.title2)
                        .autocorrectionDisabled()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .onSubmit {
                            Task {
                                do {
                                    wrapper = try await ApiNetwork().getWheaterByCity(nameCity: cityName)
                                    showButtonsSheet = true
                                    activeSheetCity = selectedCityIdentifiable(name: cityName)
                                } catch {
                                    print("Error \(error)")
                                }
                            }
                        }
                }
                .padding(.horizontal)
            }
            .cornerRadius(16)
            .frame(maxWidth: .infinity, maxHeight: 80)
            .padding(.horizontal)
            .padding(.bottom, 40)
            
        }
        .background(Color.colorBackground)
        .edgesIgnoringSafeArea(.all)
        
        .sheet(item: $activeSheetCity) { target in
            ZStack(alignment: .top) {
                WeatherDetailView(name: target.name, showActiveButtons: showButtonsSheet)
                HStack(spacing: 250) {
                        Button(action: {
                            withAnimation {
                                activeSheetCity = nil
                            }
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                .foregroundColor(.black.opacity(0.2))
                        })
                    if showButtonsSheet == true {
                        Button(action: {
                            let cleanedSearch = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !cleanedSearch.isEmpty {
                                if !store.favoriteCities.contains(where: { $0.description.lowercased() == cleanedSearch.lowercased()}){
                                    store.favoriteCities.insert(cleanedSearch, at: 0)
                                }
                            }
                            withAnimation {
                                activeSheetCity = nil
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                                .foregroundColor(.black.opacity(0.2))
                        })
                    }
                }
                .padding(.top, 20)
            }
        }
    }
    struct selectedCityIdentifiable: Identifiable {
        var id = UUID()
        var name: String
    }
}

#Preview {
    WeatherSearcher()
}
