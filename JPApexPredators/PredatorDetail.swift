//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Omar Bustanji on 06/09/2025.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    let predator : ApexPredator
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView {
                ZStack (alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable().scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .clear, location: 0.9),
                                    Gradient.Stop(color: .black, location: 1)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }

                    Image(predator.name.lowercased())
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black , radius: 7)
                        .offset(y: 20)
                }
                VStack (alignment: .leading) {
                    Text(predator.name.capitalized)
                        .font(.largeTitle)
                    Map{
                        
                    }.frame(height: 150)
                        .cornerRadius(15)
                    
                    Text("Appears in:").font(.title3)
                    ForEach(predator.movies, id: \.self){ movie in
                        Text("‧" + movie)
                    }
                    Text("Movie Moment").font(.title).padding(.top, 15)
                    ForEach(predator.movieScenes){ movieScene in
                        Text(movieScene.movie)
                            .font(.title2)
                            .padding(.vertical)
                        Text(movieScene.sceneDescription)
                            .padding(.bottom, 20)
                    }
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
                
                
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    PredatorDetail(predator: Predators().predatorsList[0])
}
