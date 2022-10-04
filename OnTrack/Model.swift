//
//  Model.swift
//  OnTrack
//
//  Created by Harsh Yadav on 04/10/22.
//

import Foundation

enum ContentType:String,Codable{
    case manga = "Manga"
    case anime = "Anime"
    case movies = "Movies"
    case books = "Books"
}

struct ItemModel:Identifiable,Codable{
    var id = UUID()
    var name: String
    var rating: Int
    var review: String
    var type:ContentType
}

protocol ContentList:Identifiable{
    var id :UUID { get set}
    var name: String { get set}
    var rating: Int { get set}
    var review: String { get set}
    
    var type:ContentType{ get set }
}
