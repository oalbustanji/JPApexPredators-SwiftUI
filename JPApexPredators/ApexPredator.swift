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
    enum ApexType: String, Decodable {
        case land
        case sea
        case air
        var color: Color {
            switch self {
            case .land:
                return .brown
            case .sea:
                return .blue
            case .air:
                return . teal
            }
        }
    }
}
