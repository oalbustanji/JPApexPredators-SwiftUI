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
    @State var currentSelection = ApexType.all
    
    var searchDinasors: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(searchText: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(searchDinasors) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Picker(
                            "Filter",
                            selection: $currentSelection.animation()) {
                                ForEach(ApexType.allCases) { type in
                                    Label(
                                        type.rawValue.capitalized,
                                        systemImage: type.icon
                                    )
                                    }
                            }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
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
