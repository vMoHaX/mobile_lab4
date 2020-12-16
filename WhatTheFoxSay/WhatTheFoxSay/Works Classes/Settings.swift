//
//  Settings.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 15.12.2020.
//

import Foundation

public class Settings{
    static private var newCellID: Int = -1
    static private var newFilmID: Int = -1
    
    static var GetNewCellID: Int {
        newCellID += 1
        return newCellID
    }
    static var GetNewFilmID: Int {
        newFilmID += 1
        return newFilmID
    }
}
