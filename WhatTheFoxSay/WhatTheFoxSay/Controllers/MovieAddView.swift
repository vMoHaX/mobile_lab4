//
//  MovieAddController.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 15.12.2020.
//

import Foundation
import UIKit

class MovieAddView: UIView, UITextFieldDelegate{
    weak var FilmsData: MoviesEntities?
    weak var FilmsTableController: ViewController?
    weak var FilmsTable: UITableView?
    
    var nameTF: UITextField = {
        var text = UITextField()
        text.placeholder = "filma name"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var typeTF: UITextField = {
        var text = UITextField()
        text.placeholder = "movie type"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var yearTF: UITextField = {
        var text = UITextField()
        text.placeholder = "release year"
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var createB: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Add film", for: .normal)
        but.backgroundColor = .darkGray
        but.setTitleColor(.white, for: .normal)
        but.setTitleColor(.green, for: .focused)
        return but
    }()
    var errorL: UILabel = {
        var text = UILabel()
        text.textColor = .red
        text.font = .italicSystemFont(ofSize: 16)
        text.text = "ERROR: some data is incorect!"
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isHidden = true
        return text
    }()
    
    private func start(){
        yearTF.delegate = self
        let off: CGFloat = 15
        
        self.addSubview(self.nameTF)
        self.addSubview(self.typeTF)
        self.addSubview(self.yearTF)
        self.addSubview(self.createB)
        self.addSubview(self.errorL)
        
        nameTF.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: off).isActive = true
        nameTF.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        nameTF.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
        nameTF.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        typeTF.topAnchor.constraint(equalTo: self.nameTF.bottomAnchor, constant: off).isActive = true
        typeTF.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        typeTF.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
        typeTF.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        yearTF.topAnchor.constraint(equalTo: self.typeTF.bottomAnchor, constant: off).isActive = true
        yearTF.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        yearTF.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
        yearTF.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        createB.topAnchor.constraint(equalTo: self.yearTF.bottomAnchor, constant: off).isActive = true
        createB.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        createB.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
        createB.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        createB.addTarget(self, action: #selector(self.addMovie), for: .touchUpInside)
        
        errorL.topAnchor.constraint(equalTo: self.createB.bottomAnchor, constant: off).isActive = true
        errorL.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: off).isActive = true
        errorL.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -off).isActive = true
    }
    init() {
        super.init(coder: NSCoder())!
        self.start()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.start()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacter = CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacter) == nil)
    }
    
    @objc func addMovie(_ sender: UIButton){
        let year = Int(yearTF.text!)
        if let y = year {
            if (y < 1895 || y > 2023) || !(nameTF.hasText && typeTF.hasText){
                self.errorL.isHidden = false
                return
            }
            let id = Settings.GetNewFilmID
            let userFilm = MoviePreview(imdbID: "userID_\(id)", Title: nameTF.text!, Type: "userFilm", Year: String(describing: y),  Poster: "User_Poster_\(id).jpg")
            FilmsData?.Search.append(userFilm)
            FilmsTable?.reloadData()
            self.errorL.isHidden = true
        }
        else{
            self.errorL.isHidden = false
            return
        }
    }
}

