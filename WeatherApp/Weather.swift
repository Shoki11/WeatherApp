//
//  Weather.swift
//  WeatherApp
//
//  Created by cmStudent on 2020/11/30.
//

import Foundation
    
struct OneCallWeather : Decodable {
    
    // 緯度
    let lat: Double
    
    // 経度
    let lon: Double
    
    // リクエストされた場所の時間
    let timezone : String
    
    // 現在の気象データAPIの応答
    let current : Current
    
    // 毎日の天気予報データAPI応答
    let daily : [Daily]
    
    
    let hourly : [Hourly]
    
    
    let minutely : [Minutely]
    
    struct Current : Decodable {
        
        /// 現在の時刻
        let dt : Int
        
        /// 温度
        let temp : Double
        
        /// 湿度
        let humidity : Int
        
        /// 日の出
        let sunrise : Int
        
        /// 日の入り
        let sunset : Int
        
        /// 体感温度
        let feels_like : Double
        
        /// 大気圧 hPa
        let pressure : Int
        
        /// UV指数
        let uvi : Double
        
        /// 雲
        let clouds : Double
        
        
        let weather : [Weather]
        
        
        struct Weather : Decodable {
            
            /// id
            let id : Int
            
            /// 気象
            let main : String
            
            /// 概要
            let description : String?
            
            /// 天気のアイコン
            let icon : String
            
        }
    }
    
    struct Hourly : Decodable {
        
        /// 降水確率
        let pop : Double
        
        /// 風速
        let wind_speed : Double
        
        /// 風向
        let wind_deg : Double
        
    }
    
    struct Minutely : Decodable {
        
        /// 降水量
        let precipitation : Double
        
    }
    
    struct Daily : Decodable {
        
        let temp : Temp
        
        struct Temp : Decodable {
            
            /// 最低気温
            let min : Double
            
            /// 最高気温
            let max : Double
            
        }
        
    }
    
}
