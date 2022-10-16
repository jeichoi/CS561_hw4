import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
    func testWeatherModel() async {
        //Given
        let sut = WeatherServiceImpl()
        let mockJsonString = """
{
  "coord": {
    "lon": -123.26,
    "lat": 44.56
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 294.13,
    "feels_like": 293.82,
    "temp_min": 293.08,
    "temp_max": 298.25,
    "pressure": 1016,
    "humidity": 59
  },
  "visibility": 10000,
  "wind": {
    "speed": 4.12,
    "deg": 310
  },
  "clouds": {
    "all": 0
  },
  "dt": 1665960009,
  "sys": {
    "type": 2,
    "id": 2005452,
    "country": "US",
    "sunrise": 1665930568,
    "sunset": 1665970039
  },
  "timezone": -25200,
  "id": 5720727,
  "name": "Corvallis",
  "cod": 200
}
"""
        
        //Wehn
        let temperature = sut.getTemperatureFromModel(jsonString: mockJsonString)
        //Then
        XCTAssertEqual(temperature, 294.13)
    }
    
    func testRealWeatherServerIntegration() async {
        //Given
        let sut = WeatherServiceImpl()
        let compareTemp = 69
        //When
        do{
            let realTemp = try await sut.getTemperature()
            //Then
            XCTAssertEqual(realTemp, compareTemp)
        } catch {
            print(error)
        }
        
    }

}
