//
//  ImageLoader.swift
//  PlacesApp
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    //Dictionary to cache the image once downloaded , instead we can use NSCache
    private var loadedImages = [URL: UIImage]()
    
    //MARK:- Load the url image and add to cache
    func loadTitleImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if let image = loadedImages[url] {
            completion(.success(image))
        }
        
        URLSessionManager.shared.sendRequest(url: url) { result in
            do {
                let data = try result.get()
                if let image = UIImage(data: data){
                    self.loadedImages[url] = image
                    completion(.success(image))
                }
            }catch{
                print("Error \(error)")
                guard (error as NSError).code == NSURLErrorCancelled else {
                    completion(.failure(error))
                    return
                }
            }
        }
    }
}

