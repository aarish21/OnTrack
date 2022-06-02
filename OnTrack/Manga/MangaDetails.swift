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
    @State private var inputImage: UIImage?
    @State private var showImagePicker = false
    let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
    
    var imageToDisplay: Image {
        if let displayedImage = inputImage {
            return Image(uiImage: displayedImage)
        } else {
            return Image(systemName: "photo")
                
        }
       
    }
    var index: Int
    var body: some View {
        
        
            
        List{
            AsyncImage(url: documentsUrl.appendingPathComponent(mangaObject.items[index].id.uuidString)){ phase in
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .contextMenu{
                            Button{
                                showImagePicker = true
                            }label: {
                                Label("Change Image", systemImage: "photo")
                            }
                            Button(role: .destructive){
                                deleteDirectory(fileName: mangaObject.items[index].id.uuidString)
                            }label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                }else if phase.error != nil {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .contextMenu{
                            Button{
                                showImagePicker = true
                            }label: {
                                Label("Add Image", systemImage: "photo")
                            }
                        }
                }else{
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
//            if (inputImage == nil) {
//                Image(systemName: "photo")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.black)
//                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                    .contextMenu{
//                        Button{
//                            showImagePicker = true
//                        }label: {
//                            Label("Add Image", systemImage: "photo")
//                        }
//                    }
//            }else{
//                imageToDisplay
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.black)
//                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                    .contextMenu{
//                        Button{
//                            showImagePicker = true
//                        }label: {
//                            Label("Change Image", systemImage: "photo")
//                        }
//                        Button(role: .destructive){
//                            deleteDirectory(fileName: mangaObject.items[index].id.uuidString)
//                        }label: {
//                            Label("Remove", systemImage: "trash")
//                        }
//                    }
//            }
                
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
            TextEditor(text: $mangaObject.items[index].review)
                .frame(height: 150)
        }
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $inputImage)
        }
        .navigationTitle(mangaObject.items[index].name)
        .onAppear {
          
            rating = mangaObject.items[index].rating
            chapters = mangaObject.items[index].chapters
        }
        .onChange(of: inputImage, perform: { _ in
            let _ =  AddView.saveImageInDocumentDirectory(image: inputImage!, fileName:  mangaObject.items[index].id.uuidString)
        })
        .onDisappear {
            saveChanges()
        }
    }
   
    func deleteDirectory(fileName: String) {
        let fileManager = FileManager.default
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)

        if fileManager.fileExists(atPath: fileURL.path){
            try! fileManager.removeItem(atPath: fileURL.path)
        }else{
            print("not deleted")
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
