//
//  MovieList.swift
//  Series on Track
//
//  Created by Aarish on 29/05/22.
//

import SwiftUI

struct MovieTracked: View {
    @ObservedObject var book = Book()
    @ObservedObject var manga = Manga()
    @ObservedObject var anime = Anime()
    @ObservedObject var movie = Movie()
    @State private var showAddOption = false
    @State private var searchText = ""
    var body: some View {
        
        List{
            ForEach(filteredMovie){ list in
                NavigationLink(destination: MovieDetails(movie: list)){
                HStack{
                    VStack(alignment: .leading){
                        Text(list.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(" Ep \(list.episode)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        HStack(spacing: 0){
                            Image(systemName: "star.circle.fill")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            Text("\(list.rating)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }.padding(.leading,3)
                        
                        Spacer()
                    }
                    Spacer()
                    Image("pun1p343mw")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 70)
                        .cornerRadius(5)
                }.frame(height: 80)
                }
            }
            .onDelete(perform: removeItems)
//
            
        }
        .searchable(text: $searchText)
        .navigationTitle("Movies & Shows")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddOption = true
                } label: {
                    Label("", systemImage: "plus")
                }
                
            }
        }
        .sheet(isPresented: $showAddOption){
            AddView(selectedOption: 2, anime: self.anime, movie: self.movie, book: self.book)
                .environmentObject(manga)
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        movie.items.remove(atOffsets: offsets)
    }
    var filteredMovie: [MoviesList]{
        if searchText.isEmpty {
            return movie.items
        }else{
            return movie.items.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct MovieTracked_Previews: PreviewProvider {
    static var previews: some View {
        MovieTracked()
    }
}
