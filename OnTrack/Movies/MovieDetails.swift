//
//  MovieDetails.swift
//  OnTrack
//
//  Created by Aarish on 31/05/22.
//

import SwiftUI

struct MovieDetails: View {

    @EnvironmentObject var movieObject : Movie
    @State private var name = ""
    @State private var rating = 1
    @State private var episodes: Int = 0
    @State private var review = ""
    var index: Int
    var body: some View {
        List{
            TextField("Name", text: $name)
            Stepper(value:$rating,in: 1...10, step: 1){
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(rating)")
                }
            }
            Stepper(value:$episodes, step: 1){
                Text("\(episodes) Episodes")
            }
            TextEditor(text: $review)
                .frame(height: 100)
        }.onAppear {
            name = movieObject.items[index].name
            rating = movieObject.items[index].rating
            episodes = movieObject.items[index].episode
            review = movieObject.items[index].review
        }
        .onDisappear {
            saveChanges()
        }
    }
    func saveChanges(){
        movieObject.items[index].name = name
        movieObject.items[index].episode = episodes
        movieObject.items[index].rating = rating
        movieObject.items[index].review = review
    }
        
}
//
//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails(movie: movie)
//    }
//}
