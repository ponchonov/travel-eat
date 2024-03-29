//
//  APIManager.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    let token = "a605aafe55ab7a1892b8d0be1985fd0e"
    let baseURL = "https://developers.zomato.com/api/v2.1/"
    
    public func mutableRequest(url:URL) -> URLRequest {
        
        let headers = [
            "user-key": token,
            "accept": "application/json",
            "content-type": "application/json"
        ]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    private func apiCallWith(request:URLRequest,parameters:Dictionary<String,Any>?, completion: @escaping (_ data:Data?,_ response: URLResponse?, _ error: Error?) -> Void) {
        let session = URLSession.shared
        var requestToSend = request;
        
        if let params = parameters {
            var queryItems = [URLQueryItem]()
            
            if var urlComp = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)  {
                for (key, value) in params {
                    let queryItem = URLQueryItem(name: key, value: value as? String)
                    queryItems.append(queryItem)
                }
                urlComp.queryItems = queryItems
                requestToSend.url = urlComp.url
            }
        }
        
        let dataTask = session.dataTask(with: requestToSend) { (data, response, error) in
            completion(data,response,error)
        }
        
        dataTask.resume()
        
    }
    
    func getSearchResult(search:String, completion: @escaping (_ cities:[City],_ error: Error?) -> Void) {
    
        let request = mutableRequest(url:  NSURL(string: "\(baseURL)/cities")! as URL)

        let parameters = [
            "q": search
            ] as [String : Any]
        
        apiCallWith(request: request, parameters: parameters) { (data, response, error) in
            var cities:[City] = [City]()
            if error == nil {
                do {
                    let decoder = JSONDecoder()
                    guard let data = data else {return}
                    let item =  try decoder.decode(LocationSuggestion.self, from: data)
                    cities = item.location_suggestions
                    completion(cities, nil)
                } catch let e {
                    completion(cities, e)
                }
            } else {
                completion(cities, error)
            }
        }
    }
    
    func getCollectionsWith(cityId:Int,completion: @escaping (_ collections:[Collection],_ error: Error?) -> Void)  {
        var collections = [Collection]()
        
        let request = mutableRequest(url:  NSURL(string: "\(baseURL)/collections")! as URL)

        let parameters = [
            "city_id": "\(cityId)"
            ] as [String : Any]
        
        apiCallWith(request: request, parameters: parameters) { (data, response, error) in
            if error == nil {
                do {
                    let decoder = JSONDecoder()
                    guard let data = data else {return}
                    let item =  try decoder.decode(Collections.self, from: data)
                    
                    for col in item.collections {
                        collections.append(col.collection)
                    }
                    completion(collections, nil)
                } catch let e {
                    completion(collections, e)
                }
            } else {
                completion(collections, error)
            }
        }
    }
    
    func getRestaurants(collectionId:Int? = nil, latitude:String? = nil, longitude:String? = nil,completion: @escaping (_ restaurants:[Restaurant],_ error: Error?) -> Void)  {
        var restaurants = [Restaurant]()
        
        let request = mutableRequest(url:  NSURL(string: "\(baseURL)/search")! as URL)
        
        let parameters:[String : Any]
        if let collectionId = collectionId {
         parameters = [
            "collection_id": "\(collectionId)"
            ] as [String : Any]
        } else {
        parameters = [
                "lat": latitude ?? "",
                "lon": longitude ?? ""
            ]
        }
        
        apiCallWith(request: request, parameters: parameters) { (data, response, error) in
            if error == nil {
                do {
                    let decoder = JSONDecoder()
                    guard let data = data else {return}
                    let item =  try decoder.decode(Restaurants.self, from: data)
                    
                    for col in item.restaurants {
                        restaurants.append(col.restaurant)
                    }
                    completion(restaurants, nil)
                } catch let e {
                    completion(restaurants, e)
                }
            } else {
                completion(restaurants, error)
            }
        }
    }
    
}
