//
//  HomeViewController.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 30/09/2022.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
  
  private let viewModel: HomeViewModel
  private var cancellables: Set<AnyCancellable> = []
  
  private lazy var dataSource = self.makeDataSource()
  
  private var searchController: UISearchController?
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 16
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.delegate = self
    collectionView.register(HomeCollectionViewCell.self,
                            forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.bindViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.viewModel.handle(action: .launchGetAllLeaguesListRequest)
  }
  
  private func bindViewModel() {
    self.viewModel.$teamsVM
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.updateSnapshot()
      }
      .store(in: &self.cancellables)
  }
  
  private func setup() {
    self.view.backgroundColor = .backgroundColor
    self.setupSearchNavigationBar()
    self.setupCollectionView()
    self.setupLayout()
    self.viewModel.autocompleteViewModel.configure(delegate: self)
  }
  
  private func setupSearchNavigationBar() {
    self.searchController = UISearchController(searchResultsController: AutocompleteViewController(viewModel: self.viewModel.autocompleteViewModel))
    self.searchController?.hidesNavigationBarDuringPresentation = false
    self.searchController?.obscuresBackgroundDuringPresentation = false
    self.searchController?.searchBar.placeholder = "League"
    self.searchController?.searchBar.accessibilityIdentifier = "LeagueSearchBar"
    
    self.searchController?.searchResultsUpdater = self
    self.searchController?.searchBar.delegate = self
    self.definesPresentationContext = true
    self.navigationItem.searchController = self.searchController
  }
  
  private func setupCollectionView() {
    self.view.addSubview(self.collectionView)
    self.collectionView.delegate = self
    self.collectionView.dataSource = self.dataSource
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
  
}

extension HomeViewController: UISearchBarDelegate {
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    if let searchText = searchController?.searchBar.text {
      self.viewModel.handle(action: .launchGetTeamsListRequest(leagueName: searchText))
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchController?.searchResultsController?.dismiss(animated: false)
  }
}

extension HomeViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    searchController.showsSearchResultsController = true
    if let searchText = searchController.searchBar.text {
      self.viewModel.autocompleteViewModel.handle(action: .setSearchQuery(searchText))
    }
  }
}

extension HomeViewController: UICollectionViewDelegate {
  private enum Section {
    case main
  }
  
  private class DataSource: UICollectionViewDiffableDataSource<Section, HomeCollectionCellViewModel> {}
  
  private func makeDataSource() -> DataSource {
    
    return DataSource(
      collectionView: self.collectionView,
      cellProvider: { collectionView, indexPath, homeCollectionCellViewModel in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
          assertionFailure("Failed to dequeue \(HomeCollectionViewCell.self)")
          return UICollectionViewCell()
        }
        cell.configure(with: homeCollectionCellViewModel)
        return cell
      }
    )
  }
  
  private func updateSnapshot(animate: Bool = false) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, HomeCollectionCellViewModel>()
    snapshot.appendSections([.main])
    snapshot.appendItems(self.viewModel.teamsVM, toSection: .main)
    self.dataSource.apply(snapshot, animatingDifferences: animate)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return }
    
    let toViewController = TeamDetailsViewController(viewModel: TeamDetailsViewModel(with: item.teamName))
    self.navigationController?.pushViewController(toViewController, animated: false)
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: (view.frame.width / 2) - 8 , height: (view.frame.width / 2) - 8 )
  }
}

extension HomeViewController: AutocompleteProtocol {
  func didSelectSuggestion(league: League) {
    guard let name = league.name else { return }
    self.viewModel.handle(action: .launchGetTeamsListRequest(leagueName: name))
    self.searchController?.searchBar.text = league.name
    self.searchController?.showsSearchResultsController = false
    
  }
}
