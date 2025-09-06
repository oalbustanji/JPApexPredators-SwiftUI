//
//  Predators.swift
//  JPApexPredators
//
//  Created by Omar Bustanji on 03/09/2025.
//

import Foundation

class Predators {
    var predatorsList: [ApexPredator] = []
    
    init() {
        convert()
    }
    func convert() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode([ApexPredator].self, from: data)
                predatorsList = decodedData
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func search (searchText: String) -> [ApexPredator] {
        if searchText.isEmpty {
            return predatorsList
        }else {
            return predatorsList.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    func sort(by alphabatical: Bool) {
         predatorsList.sort { predator1, predator2 in
             if alphabatical {
                 predator1.name < predator2.name
             }else {
                 predator1.id < predator2.id
             }
        }
    }
    func filter(by type: ApexType) -> [ApexPredator] {
        if type != .all{
            
           return  predatorsList.filter { predator in
                predator.type == type
            }
            
        }else {
            return predatorsList
        }
    }
}
