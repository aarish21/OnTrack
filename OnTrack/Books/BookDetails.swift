//
//  MovieDetails.swift
//  OnTrack
//
//  Created by Aarish on 31/05/22.
//

import SwiftUI

struct BookDetails: View {

    @EnvironmentObject var bookObject : Manga
    @State private var name = ""
    @State private var rating = 1
    @State private var chapters: Int = 0
    @State private var review = ""
    var index: Int
    var body: some View {
        List{
            TextField("Name", text: $bookObject.items[index].name)
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
            TextEditor(text: $bookObject.items[index].review)
                .frame(height: 100)
        }.onAppear {
           
            rating = bookObject.items[index].rating
            chapters = bookObject.items[index].chapters
           
        }
        .onDisappear {
            saveChanges()
        }
    }
    func saveChanges(){
       
        bookObject.items[index].chapters = chapters
        bookObject.items[index].rating = rating
       
    }
        
}
//
//struct MovieDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetails(movie: movie)
//    }
//}
