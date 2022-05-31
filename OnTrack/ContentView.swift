//
//  ContentView.swift
//  Series on Track
//
//  Created by Aarish on 29/05/22.
//

import SwiftUI

struct CustomGroup:View {
    var img = ""
    var count = ""
    var col:Color
    var label = ""
    var body: some View{
        VStack{
            GroupBox(label:
                        HStack{
                            Text("\(Image(systemName: img))")
                                .foregroundColor(col)
                                .font(.title)
                            Spacer()
                            Text(count)
                                .foregroundColor(.gray)
                                .font(.title)
                                .fontWeight(.bold)
                        }
            ){
                VStack{
                    Text("")
                    HStack{
                        Text(label)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Spacer()
                    }
                }
            }.cornerRadius(15)
                
            
        }
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @ObservedObject var book = Book()
    @ObservedObject var manga = Manga()
    @ObservedObject var anime = Anime()
    @ObservedObject var movie = Movie()
    var body: some View {
        NavigationView{
            ScrollView{
            VStack{
                HStack{
                    NavigationLink(destination: MangaTracked()) {
                        CustomGroup(img: "books.vertical", count: "\(manga.items.count)", col: Color.green, label: "Manga")
                            .environmentObject(manga)
                    }
                    NavigationLink(destination: AnimeTracked()){
                        CustomGroup(img: "tv", count: "\(anime.items.count)", col: Color.red, label: "Anime")
                    }
                    
                }.padding(.horizontal)
                HStack{
                    NavigationLink(destination: MovieTracked()) {
                        CustomGroup(img: "film", count: "\(movie.items.count)", col: Color.gray, label: "Movies & Shows")
                    }
                    NavigationLink(destination: BooksTracked()) {
                        CustomGroup(img: "text.book.closed", count: "\(book.items.count)", col: Color.blue, label: "Books")
                    }
                    
                    
                }.padding(.horizontal)
                Spacer()
            }
            
            .navigationTitle("Track")
            .searchable(text: $searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
