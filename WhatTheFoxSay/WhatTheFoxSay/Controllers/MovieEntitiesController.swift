//
//  MovieEntitiesController.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 15.12.2020.
//

import Foundation
import UIKit


class MoviesEntities: NSObject, UITableViewDataSource, Decodable{
    var Search: [MoviePreview]
    var Filtered: [MoviePreview]?
    var isFiltered: Bool{
        return Filtered != nil
    }
    
    var GetCurrentData: [MoviePreview]{
        get{
            return isFiltered ? Filtered!: Search
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = self.GetCurrentData.count
        return size == 0 ? 1: size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.GetCurrentData.count == 0){
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! EmptyCell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
            cell.movie = self.GetCurrentData[indexPath.row]
            cell.layoutSubviews()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if isFiltered{
                let index = Search.firstIndex(where: {
                    movie in return movie == Filtered![indexPath.row]
                })
                Search.remove(at: index!)
                Filtered!.remove(at: indexPath.row)
            } else {
                Search.remove(at: indexPath.row)
            }
            if GetCurrentData.count == 0{
                tableView.reloadData()
            }
            else{
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
