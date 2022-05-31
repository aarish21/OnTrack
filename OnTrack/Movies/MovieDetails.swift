//
//  MovieDetails.swift
//  OnTrack
//
//  Created by Aarish on 31/05/22.
//

import SwiftUI

struct MovieDetails: View {
    @State var movie: MoviesList
    @ObservedObject var movies : Movie
    @State private var name = ""
    @State private var rating = 1
    @State private var episodes: Int = 0
    @State private var review = ""
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
            name = movie.name
            review = movie.review
            episodes = movie.episode
            rating = movie.rating
        }
        .onDisappear {
            saveChanges()
        }
    }
    func saveChanges(){
        
    }
        
}
//
//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails(movie: movie)
//    }
//}
