//
//  EmptyCell.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 15.12.2020.
//

import Foundation
import UIKit

class EmptyCell: UITableViewCell{
    var emptyLabel: UILabel = {
        var label = UILabel()
        label.text = "Films not found!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(emptyLabel)
        emptyLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        emptyLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        emptyLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

