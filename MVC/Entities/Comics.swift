//
//  Comics.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Comics: Decodable {
    
    let id: Int
    
    let title: String
    
    let thumbnail: Thumbnail
    
    
    enum CodingKeys: String, CodingKey {
        
        case id
        
        case title
        
        case thumbnail
        
    }
}
