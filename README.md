# **WheaterApp**
Una aplicación móvil moderna y elegante para consultar el clima, desarrollada de forma nativa para iOS utilizando SwiftUI, CoreLocation y la API de OpenWeatherMap. La aplicación permite buscar el estado del tiempo por ciudades, geolocalizar al usuario en tiempo real y gestionar una lista persistente de ubicaciones favoritas.

---

## **Características Principales**
- Clima por Ubicación Actual: Geolocalización automática en tiempo real integrada con CoreLocation y actualización síncrona de datos de red.
- Búsqueda Dinámica: Motor de búsqueda por texto para consultar el clima de cualquier ciudad del mundo.
- Lista de Favoritos Persistente: Almacenamiento local mediante UserDefaults optimizado con observadores de propiedades (didSet) para evitar duplicados y mantener la consistencia entre sesiones.
- Arquitectura Limpia: Organización modular del proyecto inspirada en buenas prácticas de Clean Architecture/MVVM.
- Hojas de Detalle Fluidas: Flujo de navegación interactivo utilizando hojas nativas (.sheet(item:)) controladas por tipos de datos identificables para prevenir desajustes de estado.

---
## Tecnologías y Frameworks
- Lenguaje: Swift 5.10
- Framework de UI: SwiftUI
- Frameworks Nativos: CoreLocation (GPS), Combine (Programación reactiva)
- Persistencia: UserDefaults & JSONEncoder/Decoder
- Concurrencia: Async/Await (Modern Swift Concurrency)
- API Externa: OpenWeatherMap API

---

## Requisitos e Instalación

* **Sistema Operativo:** macOS 14.0 o superior.
* **IDE:** Xcode 15.0+ / 16.0.
* **Plataforma:** Target de despliegue para iOS 17.0+.

Para ejecutar estos proyectos localmente:
1. Clona el repositorio: `https://github.com/isaSanchez-png/WheaterApp.git`
2. Abre la carpeta del proyecto deseado en Xcode.
3. Selecciona tu simulador de iOS preferido y presiona `⌘R` (Run).

---

# **WheaterApp**
A modern and elegant weather forecasting mobile application, built natively for iOS using SwiftUI, CoreLocation, and the OpenWeatherMap API. The app enables users to search for real-time weather conditions by city name, track their current location instantly via GPS, and manage a persistent list of favorite locations.

## **Key Features**
- Current Location Weather: Real-time automatic geolocating using CoreLocation combined with responsive network synchronization.
- Dynamic Search: Quick text-based search engine to look up weather data for any global city.
- Persistent Favorites List: On-device local storage powered by UserDefaults, optimized with property observers (didSet) to prevent duplicate records and ensure data consistency.
- Clean Architecture: Structured modular organization following professional industry standard guidelines (MVVM/Clean layers).
- Fluid Detail Sheets: Highly interactive presentation layers using native .sheet(item:) tied directly to Identifiable data types, ensuring accurate UI state rendering.
                                                                                    
---

## Tech Stack & Frameworks
- Language: Swift 5.10
- UI Framework: SwiftUI
- Native Frameworks: CoreLocation (GPS), Combine (Reactive data bindings)
- Persistence: UserDefaults & JSONEncoder/Decoder
- Concurrency: Async/Await (Modern Swift Concurrency)
- External API: OpenWeatherMap API

---
## Requirements & Setup
* **OS:** macOS 14.0 or later.
* **IDE:** Xcode 15.0+ / 16.0.
* **Platform:** iOS 17.0+ deployment target.

To run these projects locally:
1. Clone the repository: `https://github.com/isaSanchez-png/WheaterApp.git`
2. Open the desired project folder in Xcode.
3. Select your preferred iOS Simulator and press `⌘R` (Run).
