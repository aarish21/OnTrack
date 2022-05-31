//
//  MovieList.swift
//  Series on Track
//
//  Created by Aarish on 29/05/22.
//

import SwiftUI

struct MangaTracked: View {
    @ObservedObject var book = Book()
    @StateObject var manga = Manga()
    @ObservedObject var anime = Anime()
    @ObservedObject var movie = Movie()
    @State private var showAddOption = false
    @State private var searchText = ""
    var body: some View {
        
        List{
            ForEach(filteredManga){ list in
                
                HStack{
                    
                    
                    VStack(alignment: .leading){
                        Text(list.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(" Ch \(list.chapters)")
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
            .onDelete(perform: removeItems)

        }
        .environmentObject(manga)
        .searchable(text: $searchText)
        .navigationTitle("Manga")
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
            AddView(selectedOption: 0, anime: self.anime, movie: self.movie, book: self.book)
                .environmentObject(manga)
        }
        
    }
    var filteredManga: [MangaList]{
        
        if searchText.isEmpty {
            return manga.items
        }else{
            return manga.items.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        manga.items.remove(atOffsets: offsets)
    }
    
}

struct MangaTracked_Previews: PreviewProvider {
    static var previews: some View {
        MangaTracked()
    }
}