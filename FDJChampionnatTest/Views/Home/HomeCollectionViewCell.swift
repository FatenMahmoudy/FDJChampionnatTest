//
//  HomeCollectionViewCell.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 30/09/2022.
//

import Foundation
import UIKit
import Kingfisher

final class HomeCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: HomeCollectionViewCell.self)
  
  private let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .backgroundColor
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let teamBadgeImageView: UIImageView = {
    let img = UIImageView()
    img.backgroundColor = .clear
    img.contentMode = .scaleToFill
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.isAccessibilityElement = true
    self.setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.teamBadgeImageView.image = nil
    self.teamBadgeImageView.backgroundColor = .clear
  }
  
  func configure(with viewModel: HomeCollectionCellViewModel) {
    self.teamBadgeImageView.kf.setImage(with: viewModel.badgeURL, placeholder: UIImage(systemName: "photo.circle.fill"))
  }
  
  private func setupUI() {
    self.backgroundColor = .backgroundColor
    
    self.containerView.addSubview(self.teamBadgeImageView)
    self.contentView.addSubview(self.containerView)
    
    NSLayoutConstraint.activate([
      self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
      self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
      self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
    ])
    
    NSLayoutConstraint.activate([
      self.teamBadgeImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
      self.teamBadgeImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
      self.teamBadgeImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
      self.teamBadgeImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
    ])
    
  }
  
}
