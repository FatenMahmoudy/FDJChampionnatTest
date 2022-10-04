//
//  AutocompleteViewController.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 03/10/2022.
//

import UIKit
import Combine

final class AutocompleteViewController: UIViewController {
  
  private let viewModel: AutocompleteViewModel
  private var cancellables: Set<AnyCancellable> = []
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.backgroundColor = .backgroundColor
    return tableView
  }()
  
  private lazy var dataSource = self.makeDataSource()
  
  init(viewModel: AutocompleteViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableView()
    self.bindViewModel()
  }
  
  private func setupTableView() {
    
    self.tableView.register(AutocompleteViewCell.self,
                            forCellReuseIdentifier: AutocompleteViewCell.reuseIdentifier)
    
    self.view.addSubview(self.tableView)
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
    ])
    
    self.tableView.delegate = self
  }
  
  private func bindViewModel() {
    self.viewModel.$leaguesVM
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.updateSnapshot()
      }
      .store(in: &self.cancellables)
  }
  
}

extension AutocompleteViewController: UITableViewDelegate {
  
  private enum Section {
    case main
  }
  
  private func makeDataSource() -> DataSource {
    return DataSource(
      tableView: self.tableView,
      cellProvider: { tableView, indexPath, viewModel in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteViewCell.reuseIdentifier) as? AutocompleteViewCell else {
          assertionFailure("Failed to dequeue \(AutocompleteViewCell.self)")
          return UITableViewCell()
        }
        cell.configure(with: viewModel)
        return cell
      }
    )
  }
  
  private func updateSnapshot(animate: Bool = false) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, AutocompleteCellViewModel>()
    snapshot.appendSections([.main])
    snapshot.appendItems(self.viewModel.leaguesVM, toSection: .main)
    self.dataSource.apply(snapshot, animatingDifferences: animate)
  }
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    if let item = self.dataSource.itemIdentifier(for: indexPath) {
      self.viewModel.handle(action: .userDidTapOnItem(league: item.league))
    }
  }
}

extension AutocompleteViewController {
  private class DataSource: UITableViewDiffableDataSource<Section, AutocompleteCellViewModel> {}
}
