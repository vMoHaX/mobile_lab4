//
//  ViewController.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 02.12.2020.
//

import UIKit

class ViewController: UIViewController	{
    var moviesData: MoviesEntities?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filmInfoView: MovieInfoView?
    var filmAddView: MovieAddView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "MoviesList", ofType: "txt"){
            if let contents = FileManager.default.contents(atPath: path){
                moviesData = try! JSONDecoder().decode(MoviesEntities.self, from: contents)
            }
        }
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = moviesData
        //self.tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        self.tableView.register(EmptyCell.self, forCellReuseIdentifier: "EmptyCell")
        self.tableView.rowHeight = 160
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        filmInfoView = segue.destination.view as? MovieInfoView
        filmAddView = segue.destination.view as? MovieAddView
        filmAddView?.FilmsTableController = self
        filmAddView?.FilmsData = moviesData
        filmAddView?.FilmsTable = tableView
        
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filmInfoView?.movie = moviesData?.GetCurrentData[indexPath.row]
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lower = searchText.lowercased()
        if lower.isEmpty{
            moviesData?.Filtered = nil
        }else{
            moviesData?.Filtered = moviesData?.Search.filter {
                return $0.Title.lowercased().contains(lower)
            }
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        moviesData?.Filtered = nil
        tableView.reloadData()
    }
}
