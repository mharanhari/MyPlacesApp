//
//  URLSessionManager.swift
//  PlacesApp
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import Foundation

/* Manage the URLSession */
struct URLSessionManager{
    
    static let shared = URLSessionManager()
    
    private init(){
    }
    
    //MARK:- Send the get request with URLRequest
    func sendRequest(urlrequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void){
                
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
                if let error = error{
                    completion(.failure(error))
                }else if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
    
    //MARK:- Send the get request with url
    func sendRequest(url: URL, completion: @escaping (Result<Data, Error>) -> Void){
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error{
                    completion(.failure(error))
                }else if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
}
