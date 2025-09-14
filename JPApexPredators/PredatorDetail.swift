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
    @State var position: MapCameraPosition
    @Namespace var nameSpace
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
                    NavigationLink {
                        PredatorMap(
                            position:
                                    .camera(
                                        MapCamera(
                                            centerCoordinate: predator.location,
                                            distance: 1000
                                        )
                                    )
                        )
                        .navigationTransition(.zoom(sourceID: 1, in: nameSpace))
                    }label:{
                        Map(position: $position){
                            Annotation(
                                predator.name,
                                coordinate: predator.location) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                }
                                .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                        
                    }
                    .matchedTransitionSource(id: 1, in: nameSpace)
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
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack{
        
        PredatorDetail(
            predator: Predators().predatorsList[1],
            position:
                    .camera(
                        MapCamera(
                            centerCoordinate: Predators().predatorsList[1].location,
                            distance: 3000
                        )
                    )
        )
    }
}
