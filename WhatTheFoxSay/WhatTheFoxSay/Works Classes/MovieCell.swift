//
//  MovieCell.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 09.12.2020.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell{
    var ID: Int = 0
    var movie: MoviePreview?
    
    var titleL: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    var yearL: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var typeL: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var posterIV: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private func start(){
        self.ID = Settings.GetNewCellID
        
        self.addSubview(posterIV)
        self.addSubview(titleL)
        self.addSubview(yearL)
        self.addSubview(typeL)
        
        let off: CGFloat = 8
        posterIV.layer.cornerRadius = 8;
        posterIV.layer.masksToBounds = true;
        
        posterIV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        posterIV.widthAnchor.constraint(equalToConstant: 90).isActive = true
        posterIV.topAnchor.constraint(equalTo: self.topAnchor, constant: off).isActive = true
        posterIV.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -off).isActive = true

        titleL.leftAnchor.constraint(equalTo: self.posterIV.rightAnchor, constant: off).isActive = true
        titleL.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -off).isActive = true
        titleL.topAnchor.constraint(equalTo: self.posterIV.topAnchor).isActive = true
        
        yearL.leftAnchor.constraint(equalTo: self.titleL.leftAnchor).isActive = true
        yearL.rightAnchor.constraint(lessThanOrEqualTo: self.titleL.rightAnchor).isActive = true
        yearL.topAnchor.constraint(equalTo: self.titleL.bottomAnchor, constant: off).isActive = true

        typeL.leftAnchor.constraint(equalTo: self.titleL.leftAnchor).isActive = true
        typeL.rightAnchor.constraint(lessThanOrEqualTo: self.titleL.rightAnchor).isActive = true
        typeL.topAnchor.constraint(equalTo: self.yearL.bottomAnchor, constant: off).isActive = true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.start()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.start()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        if let m = self.movie {
            titleL.text = m.Title
            yearL.text = m.Year
            typeL.text = m.Type
            posterIV.image = m.Poster.isEmpty ? UIImage():UIImage(named: m.Poster)
        }
    }
}

