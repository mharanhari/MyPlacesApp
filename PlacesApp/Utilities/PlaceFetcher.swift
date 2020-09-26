//
//  PlaceFetcher.swift
//  PlacesApp
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import Foundation

class PlaceFetcher {
    var placeList:[PlaceInfo] = [PlaceInfo]()

    //MARK:- To get all feed list
    func getFeeds() -> [PlaceInfo]{
        return placeList
    }
    
    //MARK:- Fetch all feeds
    func fetchallPlaces(completion: @escaping  ([PlaceInfo], String) -> Void) {
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        guard let url = URL(string:urlString) else {return}
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSessionManager.shared.sendRequest(urlrequest: request) { result in
            do {
                let data = try result.get()
                //The received JSONString is not in utf8 format, so cnovert it to utf8 type before passing to Json decoder.
                let isoString = String(data: data, encoding: .isoLatin1)
                if let utf8Data = isoString?.data(using: .utf8){
                    if let response = self.decodeJSONResponseData(responseData: utf8Data, type: PlaceResponse.self){
                        self.placeList = response.rows
                        completion(self.placeList, response.title)
                    }else{
                        //Show the error message to user, please try again later.
                    }
                }
                
            } catch {
                print(error)
                //Show the error message to user, please try again later.
            }
        }
    }
    
    //MARK:- Decode the JSON response
    func decodeJSONResponseData<T : Decodable>(responseData:Data, type: T.Type) -> T? {
        var decodedObj : T?
        do{
            decodedObj = try JSONDecoder().decode(T.self, from: responseData)
        }catch let error {
            print("Parsor Error", error)
        }
        return decodedObj
    }
}

