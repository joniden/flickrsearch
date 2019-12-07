//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  // MARK: - Vars
  
  var images: [ResultImage] = []
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchController()
  }
  
  // MARK: - SearchController

  func setupSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Try forest or car"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }

}

// MARK: - Extensions

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }  
}

extension SearchViewController: UICollectionViewDelegate {
  
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let identifier = ResultImageCollectionViewCell.identifier
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ResultImageCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.setup(images[indexPath.row])
    return cell
    
  }
  
}

