//
//  FilmInfo.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 07.12.2020.
//

import Foundation
import UIKit

struct MoviePreview: Decodable{
    var imdbID: String
    var Title: String
    var `Type`: String
    var Year: String
    var Poster: String
    
    static func ==(lhs: MoviePreview, rhs: MoviePreview) -> Bool {
        return lhs.imdbID == rhs.imdbID || lhs.Title.elementsEqual(rhs.Title)
    }
}

struct MovieDescription: Decodable{
    var imdbID: String
    var Title: String
    var `Type`: String
    var Year: String
    var Poster: String
    var Genre: String?
    var Rated: String?
    var Released: String?
    var Runtime: String?
    var Language: String?
    var Country: String?
    var Director: String?
    var Writer: String?
    var Actors: String?
    var Production: String?
    var Plot: String?
    var Awards: String?
    var imdbRating: String?
    var imdbVotes: String?
}
