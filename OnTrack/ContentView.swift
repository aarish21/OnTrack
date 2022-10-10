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
                            .font(.subheadline)
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
    @ObservedObject var book : Book
    @ObservedObject var manga : Manga
    @ObservedObject var anime : Anime
    @StateObject var movie : Movie
    @State var movieCount: Int?
    @State var bookCount: Int?
    @State var animeCount : Int?
    @State var mangaCount: Int?
    @State var searchResult:[ItemModel] = []
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    if(searchText.isEmpty){
                        VStack{
                            HStack{
                                NavigationLink(destination: MangaTracked(book: book, manga: manga, anime: anime, movie: movie)) {
                                    CustomGroup(img: "books.vertical", count: "\(manga.items.count)", col: Color.green, label: "Manga")
                                    
                                }
                                NavigationLink(destination: AnimeTracked(book: book, manga: manga, anime: anime, movie: movie)){
                                    CustomGroup(img: "tv", count: "\(anime.items.count)", col: Color.red, label: "Anime")
                                }
                                
                            }.padding(.horizontal)
                            HStack{
                                NavigationLink(destination: MovieTracked(book: book, manga: manga, anime: anime, movie: movie)) {
                                    CustomGroup(img: "film", count: "\(movie.items.count)", col: Color.gray, label: "Movies & Shows")
                                }
                                NavigationLink(destination: BooksTracked(book: book, manga: manga, anime: anime, movie: movie)) {
                                    CustomGroup(img: "text.book.closed", count: "\(book.items.count)", col: Color.blue, label: "Books")
                                }
                                
                                
                            }.padding(.horizontal)
                            Spacer()
                        }
                    }else{
                        VStack(alignment: .leading){
                            ForEach(searchResult.indices, id: \.self){ index in
                                HStack(spacing: 10){
                                    VStack(alignment: .leading){
                                        Text("\(searchResult[index].name)")
                                            .font(.title2)
                                            .bold()
                                        
                                        HStack(spacing: 10){
                                            Text("\(searchResult[index].type.rawValue)")
                                            Text("⭐️\(searchResult[index].rating)")
                                        }.foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background{
                                    Color.secondary.opacity(0.1).cornerRadius(10)
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .onChange(of: searchText, perform: { _ in
                    self.searchResult =  searchItems()
                })
                .onAppear(perform: {
                    
                    //                mangaCount = manga.items.count
                    //                bookCount = book.items.count
                    //                animeCount = anime.items.count
                    //                movieCount = movie.items.count
                })
                .navigationTitle("Track")
                .searchable(text: $searchText)
            }
        }
    }
        
        
        func searchItems()->[ItemModel]{
            let animeSearchResult = anime.items.filter({$0.name.localizedCaseInsensitiveContains(searchText)})
            let mangaSearchResult = manga.items.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
            let movieSearchResult = movie.items.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
            let booksSearchResult = book.items.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
            let searchResult:[any ContentList] = animeSearchResult+mangaSearchResult+movieSearchResult+booksSearchResult
            let result = searchResult.map({ItemModel(id: $0.id, name: $0.name, rating: $0.rating, review: $0.review, type: $0.type)})
            return result
        }
   
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
