import Alamofire
import Foundation

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

class WeatherServiceImpl: WeatherService {
    let url = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=imperial&appid=<INSERT YOUR API KEY HERE>"

    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func getTemperatureFromModel(jsonString: String ) -> Double{
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        var temperature = 0.0
        do{
            let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
            temperature = weather.main.temp
        }catch{
           print(error)
        }
        
        return temperature
    }
}

private struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
