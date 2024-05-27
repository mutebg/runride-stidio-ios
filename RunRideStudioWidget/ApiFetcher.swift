//
//  ApiFetcher.swift
//  RunRideStudioWidget
//
//  Created by Stoyan Delev on 10.03.24.
//

import Foundation

struct StravaData: Decodable {
    let v: Double
    let a: Int
}

struct SnapshotData: Decodable {
    let d: Double
    let dd: Double
    let t: Int
    let td: Int
    let e: Int
    let ed: Int
    let a: Int
    let ad: Int
}

struct ApiFetcher {
    
    static var baseUrl = "https://api-izq36taffa-uc.a.run.app/mobile/"
    
    static func fetchData(sport: String, interval: String, metric: String) async throws -> StravaData {
        
        var token = ""
        if  let cToken = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "token")  {
            token = cToken
        }
        
        let url = URL(string: baseUrl + "simple?type=" + sport + "&token=" + token + "&interval=" + interval + "&metric=" + metric)!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let stravaData = try JSONDecoder().decode(StravaData.self, from: data)
            print("fetch:OK")
            return stravaData
        } catch {
            print("fetch:Error", error);
            throw error // Rethrow the error for handling at a higher level
        }
    }
    
    static func fetchSnapshot(sport: String, interval: String) async throws -> SnapshotData {

        var token = ""
        if  let cToken = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "token")  {
            token = cToken
        }
        
        let url = URL(string: baseUrl + "snapshot?type=" + sport + "&token=" + token + "&interval=" + interval)!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let snapshotData = try JSONDecoder().decode(SnapshotData.self, from: data)
            print("fetch:OK")
            return snapshotData
        } catch {
            print("fetch:Error", error);
            throw error // Rethrow the error for handling at a higher level
        }
    }
}
