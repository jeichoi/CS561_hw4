const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/data/2.5/weather', (req, res) => {
    res.json({
        "coord": {
          "lon": -123.262,
          "lat": 44.5646
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 285.53,
          "feels_like": 284.65,
          "temp_min": 283.28,
          "temp_max": 287.75,
          "pressure": 1010,
          "humidity": 70
        },
        "visibility": 10000,
        "wind": {
          "speed": 5.14,
          "deg": 260,
          "gust": 8.23
        },
        "clouds": {
          "all": 40
        },
        "dt": 1666479241,
        "sys": {
          "type": 2,
          "id": 2040223,
          "country": "US",
          "sunrise": 1666449437,
          "sunset": 1666487844
        },
        "timezone": -25200,
        "id": 5720727,
        "name": "Corvallis",
        "cod": 200
      })
  })

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
