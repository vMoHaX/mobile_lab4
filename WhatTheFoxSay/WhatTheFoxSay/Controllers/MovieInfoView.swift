//
//  MovieInfoController.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 15.12.2020.
//

import Foundation
import UIKit

class MovieInfoView: UIView{
    var movie: MoviePreview? {
        didSet(oldValue){
            self.updateData()
        }
    }
    
    var textTB: UITextView = {
        var text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isEditable = false
        return text
    }()
    var posterIV: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private func start(){
        self.addSubview(self.textTB)
        self.addSubview(self.posterIV)
        let off: CGFloat = 10
        
        posterIV.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: off).isActive = true
        posterIV.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        posterIV.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
        posterIV.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        
        textTB.topAnchor.constraint(equalTo: self.posterIV.bottomAnchor, constant: off).isActive = true
        textTB.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        textTB.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
        textTB.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -off).isActive = true
    }
    init() {
        super.init(coder: NSCoder())!
        self.start()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.start()
    }
    
    private func updateData(){
        self.textTB.text = ""
        self.posterIV.image = UIImage()
        
        var text = "ERROR film data."
        var movieData: MovieDescription?
        
        if let m = movie{
            if let path = Bundle.main.path(forResource: m.imdbID, ofType: "txt"){
                if let contents = FileManager.default.contents(atPath: path){
                    movieData = try! JSONDecoder().decode(MovieDescription.self, from: contents)
                }
            }
            text =
            """
            Title: \((movieData?.Title.isEmpty ?? true) ? m.Title : movieData!.Title)

            Plot: \(movieData?.Plot ?? "-")

            Actors: \(movieData?.Actors ?? "-")

            Awards: \(movieData?.Awards ?? "-")

            Country: \(movieData?.Country ?? "-")

            Director: \(movieData?.Director ?? "-")

            Genre: \(movieData?.Genre ?? "-")

            Language: \(movieData?.Language ?? "-")

            Production: \(movieData?.Production ?? "-")

            Rated: \(movieData?.Rated ?? "-")

            Released: \(movieData?.Released ?? "-")

            Runtime: \(movieData?.Runtime ?? "-")

            Writer: \(movieData?.Writer ?? "-")

            Year: \((movieData?.Year.isEmpty ?? true) ? m.Year : movieData!.Year)

            imdb ID: \((movieData?.imdbID.isEmpty ?? true) ? m.imdbID : movieData!.imdbID)

            imdb Rating: \(movieData?.imdbRating ?? "-")

            imdb Votes: \(movieData?.imdbVotes ?? "-")
            """
            if let p = movieData?.Poster{
                if !p.isEmpty{
                    self.posterIV.image = UIImage(named: p)
                } else if !m.Poster.isEmpty{
                    self.posterIV.image = UIImage(named: m.Poster)
                }
            }
            else if !m.Poster.isEmpty{
                self.posterIV.image = UIImage(named: m.Poster)
            }
        }
        self.textTB.text = text
    }
}

