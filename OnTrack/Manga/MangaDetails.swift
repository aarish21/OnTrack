//
//  MovieDetails.swift
//  OnTrack
//
//  Created by Aarish on 31/05/22.
//

import SwiftUI

struct MangaDetails: View {

    @EnvironmentObject var mangaObject : Manga
    @State private var name = ""
    @State private var rating = 1
    @State private var chapters: Int = 0
    @State private var review = ""
    var index: Int
    var body: some View {
        List{
            TextField("Name", text: $mangaObject.items[index].name)
            Stepper(value:$rating,in: 1...10, step: 1){
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(rating)")
                }
            }
            Stepper(value:$chapters, in: 0...30000,step: 1){
                Text("\(chapters) Chapters")
            }
            TextEditor(text: $review)
                .frame(height: 100)
        }.onAppear {
           
            rating = mangaObject.items[index].rating
            chapters = mangaObject.items[index].chapters
           
        }
        .onDisappear {
            saveChanges()
        }
    }
    func saveChanges(){
       
        mangaObject.items[index].chapters = chapters
        mangaObject.items[index].rating = rating
       
    }
        
}
//
//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails(movie: movie)
//    }
//}
