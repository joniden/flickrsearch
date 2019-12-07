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
  
  var images: [ResultImage] = [] {
    didSet {
      collectionView.reloadData()
      paginationView.isHidden = images.count == 0
    }
  }
  
  var presenter: SearchPresenter?
  
  let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var paginationView: PaginationView!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter = SearchPresenter(self)
    setupSearchController()
    setupCollectionView()
    setupPagination()
  }
  
  // MARK: - SearchController

  private func setupSearchController() {
  
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Try for example forest or car"
    searchController.searchBar.delegate = self
    
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.register(ResultImageCollectionViewCell.nib, forCellWithReuseIdentifier: ResultImageCollectionViewCell.identifier)
  }
  
  private func setupPagination() {
    paginationView.setCurrentInfo(currentPage: 0, totalPages: 0)
  }
  
  // MARK: - Alert
  
  func showAlert(_ string: String) {
    print(string)
  }

}

// MARK: - Extensions

extension SearchViewController: UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      presenter?.search(text)
    }
  }
}

extension SearchViewController: UICollectionViewDelegate {
  
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      let width = collectionView.bounds.width/3.0
      let height = width

      return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets.zero
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
  }
  
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

