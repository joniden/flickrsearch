//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchController()
    // Do any additional setup after loading the view.
  }

  func setupSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Try forest or car"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }

}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }  
}

extension SearchViewController: UICollectionViewDelegate {
  
}

extension SearchViewController: UICollectionViewDataSource {
  
}

