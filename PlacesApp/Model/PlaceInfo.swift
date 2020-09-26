//
//  PlaceInfo.swift
//  PlacesApp
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import Foundation

/* To decode the JSON response */
struct PlaceResponse:Decodable{
    var title:String
    var rows:[PlaceInfo]
    
    enum  CodingKeys : String, CodingKey{
        case title
        case rows = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.rows = try container.decode([PlaceInfo].self, forKey: .rows)
    }
}

/* To decode the FeedInfo */
struct PlaceInfo:Decodable {
    let title:String?
    let description:String?
    let imageHref:String?
}
