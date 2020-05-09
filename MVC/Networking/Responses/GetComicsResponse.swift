//
//  GetComicsResponse.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

struct GetComicsResponse: Decodable {
    
    let status: String
    
    let data: ComicsData
    
    enum CodingKeys: String, CodingKey {
        
        case status
        
        case data
        
    }
    
}

extension GetComicsResponse {
    
    struct ComicsData: Decodable {
        
        let count: Int
        
        let results: [Comics]
        
        enum CodingKeys: String, CodingKey {
            
            case count
            
            case results
            
        }
    }
}
