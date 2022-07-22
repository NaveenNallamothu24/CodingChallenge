//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Naveen Nallamothu on 07/21/22.
//

import UIKit

class ViewController: UITableViewController {
    var searchController : UISearchController?
    let dataSource = AcronymsDataSource()
    lazy var viewModel : AcronymsViewModel = {
        let viewModel = AcronymsViewModel(dataSource: dataSource)
        return viewModel
    }()
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Acronyms"
        self.tableView.dataSource = self.dataSource
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        setUpSerach()
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.setLoader(show: false)
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onErrorHandling = { [weak self] (title,errorMesage) in
            // display error ?
            self?.setLoader(show: false)
            let controller = UIAlertController(title: title, message: errorMesage, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            DispatchQueue.main.async {
                self?.present(controller, animated: true, completion: nil)
            }
            
        }
    }

    func setUpSerach() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search Acronyms"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func setLoader(show:Bool) {
        DispatchQueue.main.async {[weak self] in
            if show {
                self?.spinner.startAnimating()
                self?.tableView.backgroundView = self?.spinner
            } else {
                self?.spinner.stopAnimating()
                self?.spinner.removeFromSuperview()
            }
        }
    }
    
    func searchAcronyms(searchText:String?) {
        guard let word = searchText else {
            print("Word should not be null ")
            return
        }
        if word.isEmpty {
            print("Word should not be nil")
        }
        setLoader(show: true)
        self.viewModel.fetchAcronymsResults(word: word)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchAcronyms(searchText: searchBar.text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.clear()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.viewModel.clear()
        }
    }
}

