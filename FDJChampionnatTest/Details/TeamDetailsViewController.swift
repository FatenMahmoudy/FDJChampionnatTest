//
//  TeamDetailsViewController.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 02/10/2022.
//

import Foundation
import UIKit
import Kingfisher
import Combine

final class TeamDetailsViewController: UIViewController {
  
  private(set) var viewModel: TeamDetailsViewModel
  private var cancellables = Set<AnyCancellable>()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .backgroundColor
    scrollView.accessibilityIdentifier = "scrollView"
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let teamBannerImageView: UIImageView = {
    let img = UIImageView()
    img.backgroundColor = .clear
    img.contentMode = .scaleToFill
    img.accessibilityIdentifier = "teamBannerImageView"
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let countryLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    label.numberOfLines = 1
    label.isUserInteractionEnabled = true
    label.accessibilityIdentifier = "countryLabel"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let championshipLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    label.numberOfLines = 1
    label.accessibilityIdentifier = "championshipLabel"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  init(viewModel: TeamDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.bindViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .backgroundColor
    self.viewModel.handle(action: .launchGetTeamDetailsRequest)
  }
  
  private func bindViewModel() {
    self.viewModel.$team
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.setup()
      }
      .store(in: &self.cancellables)
  }
  
  private func setup() {
    self.setupNavigationBar()
    self.setupViews()
    self.setupLayout()
  }
  
  private func setupNavigationBar() {
    self.title = self.viewModel.teamName
  }
  
  private func setupViews() {
    self.countryLabel.text = viewModel.team?.country
    self.championshipLabel.text = viewModel.team?.championship
    self.descriptionLabel.text = viewModel.team?.description
    
    self.teamBannerImageView.kf.setImage(with: URL(string: viewModel.team?.banner ?? ""), placeholder: UIImage(systemName: "photo"))
  }
  
  private func setupLayout() {
    self.scrollView.addSubview(self.teamBannerImageView)
    self.scrollView.addSubview(self.countryLabel)
    self.scrollView.addSubview(self.championshipLabel)
    self.scrollView.addSubview(self.descriptionLabel)
    
    self.view.addSubview(self.scrollView)
    
    NSLayoutConstraint.activate([
      self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
    ])
    
    NSLayoutConstraint.activate([
      self.teamBannerImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
      self.teamBannerImageView.heightAnchor.constraint(equalToConstant: 100),
      self.teamBannerImageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
      self.teamBannerImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 16),
      self.teamBannerImageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
    ])
    
    NSLayoutConstraint.activate([
      self.countryLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
      self.countryLabel.topAnchor.constraint(equalTo: self.teamBannerImageView.bottomAnchor, constant: 16),
      self.countryLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
    ])
    
    NSLayoutConstraint.activate([
      self.championshipLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
      self.championshipLabel.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: 8),
      self.championshipLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
    ])
    
    NSLayoutConstraint.activate([
      self.descriptionLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
      self.descriptionLabel.topAnchor.constraint(equalTo: self.championshipLabel.bottomAnchor, constant: 16),
      self.descriptionLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
      self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -16),
    ])
  }
  
}
