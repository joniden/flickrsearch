//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Joacim Nidén on 2019-12-07.
//  Copyright © 2019 Joacim Nidén. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
  
  // MARK: - Vars
  
  private var images: [ResultImage] = [] {
    didSet {
      collectionView.reloadData()
      paginationView.isHidden = images.count == 0
    }
  }
  
  private var searchString: String?
  
  var selectedCell: ResultImageCollectionViewCell?
  let animator = GrowAnimator()
  
  let searchController = UISearchController(searchResultsController: nil)
  private let segueIdentifier = "showImageDetails"
  private var presenter: SearchPresenter?
  
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
      segue.identifier == segueIdentifier,
      let vc = segue.destination as? ImageDetailsViewController,
      let cell = selectedCell
    else {
       return
    }
    
    // We are using a custom transition
    vc.transitioningDelegate = self
    vc.modalPresentationStyle = .custom
    vc.setResultImage(cell.resultImage)
  }
  
  func updateView(_ viewModel: SearchResultViewModel) {
    hideActivityIndicator()
    images = viewModel.photos
    paginationView.setCurrentInfo(currentPage: viewModel.page, totalPages: viewModel.pages)
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
    
    paginationView.didPressNext = { page in
      self.paginate(page)
    }
    
    paginationView.didPressBack = { page in
      self.paginate(page)
    }
  }
  
  private func paginate(_ page: Int) {
    if let searchString = self.searchString {
      showActivityIndicator()
      presenter?.search(string: searchString, page: page)
    }
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
      searchString = text
      paginate(1)
    }
  }
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedCell = collectionView.cellForItem(at: indexPath) as? ResultImageCollectionViewCell
    performSegue(withIdentifier: segueIdentifier, sender: self)
  }
}

extension SearchViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let cell = selectedCell,
            let originFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return animator
        }
        
        animator.presenting = true
        animator.originFrame = originFrame
        return animator
    }
  
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}

