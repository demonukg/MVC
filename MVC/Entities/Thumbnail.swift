//
//  Thumbnail.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    
    var url: URL? {
        return URL(string: "\(path).\(ext)")
    }
    
    let path: String
    
    let ext: String
    
    enum CodingKeys: String, CodingKey {
        
        case path
        
        case ext = "extension"
        
    }
}
