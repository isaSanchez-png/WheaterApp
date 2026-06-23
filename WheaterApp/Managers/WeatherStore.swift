//
//  WeatherStore.swift
//  WheaterApp
//
//  Created by Isa on 23/06/26.
//
import Foundation
internal import Combine

class WeatherStore: ObservableObject {
    
    @Published var favoriteCities: [String] = [] {
        didSet{
            saveCities()
        }
    }
    private let key = "favoriteCities"
    
    init() {
        loadCities()
    }
    
    private func saveCities() {
        if let encoded = try? JSONEncoder().encode(favoriteCities) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func loadCities() {
        if let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode([String].self, from: data) {
            self.favoriteCities = decoded
        }
    }
}
