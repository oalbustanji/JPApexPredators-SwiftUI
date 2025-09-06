//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Omar Bustanji on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    @State var alphabetical = false
    
    var filterDinasors: [ApexPredator] {
        predators.sort(by: alphabetical)
        return predators.search(searchText: searchText)
    }
    var body: some View {
        NavigationStack{
            List(filterDinasors) { predator in
                NavigationLink {
                    Image(predator.image)
                }label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .shadow(color: .white, radius: 2)
                        VStack(alignment: .leading) {
                            
                            Text(predator.name).fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.color)
                                .clipShape(.capsule)
                        }
                    }
                    
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .animation(.default, value: alphabetical)
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        alphabetical.toggle()
                    }label:{
                        Image(systemName: alphabetical ? "film" : "textformat" )
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    ContentView()
}
