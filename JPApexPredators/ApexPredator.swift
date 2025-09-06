//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Omar Bustanji on 03/09/2025.
//

import Foundation
import SwiftUI

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: ApexType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    var image: String {
        
        return self.name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
   
}
enum ApexType: String, Decodable, CaseIterable, Identifiable{
    
    case all
    case land
    case sea
    case air
    
    var id: ApexType {
        return self
    }
    var color: Color {
        switch self {
        case .all:
            return .black
        case .land:
            return .brown
        case .sea:
            return .blue
        case .air:
            return . teal
        }
    }
    var icon: String {
        switch self {
            
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .sea:
            "drop.fill"
        case .air:
            "wind"
           
            
        }
    }
}
