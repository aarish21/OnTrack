//
//  AddView.swift
//  Series on Track
//
//  Created by Aarish on 29/05/22.
//

import SwiftUI
import UIKit
let saveManga = FileManager.documentsDirectory.appendingPathComponent("saveManga")
let saveAnime = FileManager.documentsDirectory.appendingPathComponent("saveAnime")
let saveMovies = FileManager.documentsDirectory.appendingPathComponent("saveMovies")
let saveBooks = FileManager.documentsDirectory.appendingPathComponent("saveBooks")

let generator = UINotificationFeedbackGenerator()
struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State  var selectedOption: Int
    @State private var image: Image?
    @State private var name = ""
    @State private var rating = 1
    @State private var episodes =  0
    @State private var chapters = 0
    @State private var review = ""
    
    @State private var showImagePicker = false
    @State private var showAlert = false
    @State private var inputImage: UIImage?

    
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
                        showImagePicker = true
                    }label: {
                        Label("Add Image", systemImage: "photo")
                    }
                }
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onChange(of: inputImage){ _ in
                loadImage()
            }
            .sheet(isPresented: $showImagePicker){
                ImagePicker(image: $inputImage)
            }
            .navigationTitle("Add Item")
            .alert(isPresented: $showAlert){
                Alert(title: Text("Textfield Empty"), message: Text("Enter Name"), dismissButton: .default(Text("Continue")))
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        if name.isEmpty  {
                            showAlert = true
                        }else{
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
    }
    public static func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileURL
        }
        return nil
    }
    
    public static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    func addManga(){
        let item = MangaList(name: name, rating: rating, chapters: chapters, review: review)
       let _ =  AddView.saveImageInDocumentDirectory(image: inputImage!, fileName: item.id.uuidString)
        
        self.manga.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    func addAnime(){
        let item = AnimeList(name: name, rating: rating, episode: episodes , review: review)
        self.anime.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    func addMovies(){
        let item = MoviesList(name: name, rating: rating, episode: episodes , review: review)
        self.movie.items.append(item)
        generator.notificationOccurred(.success)
        dismiss()
    }
    func addBooks(){
        let item = BookList(name: name, rating: rating, chapters: chapters , review: review)
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

