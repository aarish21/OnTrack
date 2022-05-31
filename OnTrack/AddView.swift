//
//  AddView.swift
//  Series on Track
//
//  Created by Aarish on 29/05/22.
//

import SwiftUI

let saveManga = FileManager.documentsDirectory.appendingPathComponent("saveManga")
let saveAnime = FileManager.documentsDirectory.appendingPathComponent("saveAnime")
let saveMovies = FileManager.documentsDirectory.appendingPathComponent("saveMovies")
let saveBooks = FileManager.documentsDirectory.appendingPathComponent("saveBooks")


struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State  var selectedOption: Int
    @State private var name = ""
    @State private var rating = 1
    @State private var episodes: Int?
    @State private var chapters: Int?
    @State private var review = ""
    let generator = UINotificationFeedbackGenerator()
        
    @ObservedObject var manga: Manga
    @ObservedObject var anime: Anime
    @ObservedObject var movie: Movie
    @ObservedObject var book: Book
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Name", text:$name)
                    
                    Stepper(value:$rating,in: 1...10, step: 1){
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(rating)")
                        }
                    }
                    if selectedOption == 0 || selectedOption == 4{
                        TextField("Chapters", value:$chapters, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    else{
                        TextField("Episodes", value:$episodes, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    
                }
                Section("Review"){
                    TextEditor(text: $review)
                        .frame(height: 100)
                }
                Section{
                    Button{
                        
                    }label: {
                        Label("Add Image", systemImage: "photo")
                    }
                }
            }
            .navigationTitle("Add Item")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        if selectedOption == 0{
                            addManga()
                        }else if selectedOption == 1{
                            addAnime()
                        }else if selectedOption == 2{
                            addMovies()
                        }else{
                            addBooks()
                        }
                    }
                }
            }
        }
    }
    func addManga(){
        let item = MangaList(name: name, rating: rating, chapters: chapters ?? 0, review: review)
        self.manga.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    func addAnime(){
        let item = AnimeList(name: name, rating: rating, episode: episodes ?? 0, review: review)
        self.anime.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    func addMovies(){
        let item = MoviesList(name: name, rating: rating, episode: episodes ?? 0, review: review)
        self.movie.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    func addBooks(){
        let item = BookList(name: name, rating: rating, chapters: chapters ?? 0, review: review)
        self.book.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    
   
}

//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView(selectedOption: 0, manga: Manga(), anime: Anime(), movie: Movie(), book: Book())
//        
//    }
//}
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

