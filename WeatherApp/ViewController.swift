//
//  ViewController.swift
//  WeatherApp
//
//  Created by cmStudent on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {

    /// 気温のラベル
    @IBOutlet weak var temperature: UILabel!
    /// 気象のラベル
    @IBOutlet weak var weatherText: UILabel!
    /// 最高気温のラベル
    @IBOutlet weak var maxText: UILabel!
    /// 最低気温のラベル
    @IBOutlet weak var minText: UILabel!
    /// 降水量のラベル
    @IBOutlet weak var precipitationText: UILabel!
    /// 降水確率のラベル
    @IBOutlet weak var popText: UILabel!
    /// 湿度のラベル
    @IBOutlet weak var humidityText: UILabel!
    /// 体感温度のラベル
    @IBOutlet weak var feelsLikeText: UILabel!
    /// 大気圧のラベル
    @IBOutlet weak var pressureText: UILabel!
    /// UV指数のラベル
    @IBOutlet weak var uviText: UILabel!
    /// 天気のアイコンのImageView
    @IBOutlet weak var displayWeatherIcon: UIImageView!
    /// 風速のラベル
    @IBOutlet weak var windSpead: UILabel!
    /// 雲のラベル
    @IBOutlet weak var cloudText: UILabel!
    
    
    //let url = "http://api.openweathermap.org/data/2.5/onecall?lat=35.69887668244874&lon=139.69658647246087&lang=ja&units=metric&appid=6d51a05326461ff1631db5fe6396980c"
    
    let url = "https://api.openweathermap.org/data/2.5/onecall"
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        guard var urlComponents = URLComponents(string: url) else {
            
            print("エラー")
            
            return
            
        }
        
        urlComponents.queryItems = [
            
            URLQueryItem(name: "lat", value: "35.69887668244874"),
            URLQueryItem(name: "lon", value: "139.69658647246087"),
            URLQueryItem(name: "lang", value: "ja"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "6d51a05326461ff1631db5fe6396980c")

        ]
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            do {
                
                let data = try JSONDecoder().decode(OneCallWeather.self, from: data!)
                
                print(data)
                
                // 呼び出す
                DispatchQueue.main.async {
                    
                    
                    // 気温
                    self.temperature.text = String(Int(data.current.temp)) + "℃"
                    
                    // 気象
                    self.weatherText.text = String(data.current.weather[0].description!)
                    
                    // 最高気温
                    self.maxText.text = String(Int(data.daily[0].temp.max)) + "℃"
                    
                    // 最低気温
                    self.minText.text = String(Int(data.daily[0].temp.min)) + "℃"
                    
                    // 降水量
                    self.precipitationText.text = String(floor(data.minutely[0].precipitation)) + "mm"
                    
                    // 降水確率
                    self.popText.text = String(Double(data.hourly[0].pop)) + "%"
                    
                    // 湿度
                    self.humidityText.text = String(Int(data.current.humidity)) + "%"
                    
                    // 体感温度
                    self.feelsLikeText.text = String(Int(data.current.feels_like)) + "℃"
                    
                    // 大気圧
                    self.pressureText.text = String(data.current.pressure) + "hPa"
                    
                    // UV指標
                    self.uviText.text = String(Int(data.current.uvi))
                    
                    /// アイコン取得
                    self.displayWeatherIcon.image = self.getWeatherIcon(icon: data.current.weather[0].icon)
                    
                    /// 風速
                    self.windSpead.text = String(Int(data.hourly[0].wind_speed)) + "m/s"
                    
                    /// 曇
                    self.cloudText.text = String(Int(data.current.clouds)) + "%"
                    
                    
                    /// 背景画像
                    //self.imageView.image = self.getBackground(id: data.current.weather[0].id)
                    
                    
                }
                
            } catch {
                
                print(error)
                
            }
            
        }
        
        task.resume()
        
    }
    
    func getWeatherIcon(icon: String) -> UIImage? {
        
        let urlString = "https://openweathermap.org/img/wn/\(icon)@4x.png"
        
        // iconURLがnill出なかった時に処理続行
        // nillだったらreturn
        guard let iconURL = URL(string: urlString) else {
            
            return UIImage()
            
        }
        
        do {
            
            let data = try Data(contentsOf: iconURL)
            
            return UIImage(data: data)!
            
        } catch {
            
            print(error)
            
        }
        
        return UIImage()
        
    }
    
    
    
    
    
    
    // idで背景を変える時に使用
    // 今回は使用しないが試しにやってみた
//    func getBackground(id : Int) -> UIImage{
//
//        // 晴れ
//        if(id == 800){
//
//            return UIImage(named: "晴れの画像")!
//
//        // くもり
//        } else if(id >= 800 && id <= 804) {
//
//            return UIImage(named: "曇りの画像")!
//
//            // 雷雨
//        } else if(id <= 200 && id >= 232) {
//
//            return UIImage(named: "曇りの画像")!
//
//            // 雨
//        } else if(id <= 500 && id >= 531) {
//
//            return UIImage(named: "雨の画像")!
//
//        }
//
//        return UIImage()
//
//    }
}

