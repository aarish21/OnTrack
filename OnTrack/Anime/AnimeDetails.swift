//
//  MovieDetails.swift
//  OnTrack
//
//  Created by Aarish on 31/05/22.
//

import SwiftUI

struct AnimeDetails: View {

    @EnvironmentObject var animeObject : Anime
    @State private var name = ""
    @State private var rating = 1
    @State private var episodes: Int = 0
    @State private var review = ""
    var index: Int
    var body: some View {
        List{
            TextField("Name", text: $animeObject.items[index].name)
            Stepper(value:$rating,in: 1...10, step: 1){
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(rating)")
                }
            }
            Stepper(value:$episodes, in: 0...30000,step: 1){
                Text("\(episodes) Episodes")
            }
            TextEditor(text: $review)
                .frame(height: 100)
        }.onAppear {
           
            rating = animeObject.items[index].rating
            episodes = animeObject.items[index].episode
           
        }
        .onDisappear {
            saveChanges()
        }
    }
    func saveChanges(){
       
        animeObject.items[index].episode = episodes
        animeObject.items[index].rating = rating
       
    }
        
}
//
//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails(movie: movie)
//    }
//}
