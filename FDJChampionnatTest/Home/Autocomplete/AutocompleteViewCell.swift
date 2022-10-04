//
//  AutocompleteViewCell.swift
//  FDJChampionnatTest
//
//  Created by Faten Mahmoudi on 04/10/2022.
//

import UIKit

final class AutocompleteViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: AutocompleteViewCell.self)
  
  private let pictoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(systemName: "magnifyingglass")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.backgroundColor = .backgroundColor
    self.selectionStyle = .none
    self.contentView.addSubview(self.pictoImageView)
    NSLayoutConstraint.activate([
      self.pictoImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      self.pictoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
      self.pictoImageView.heightAnchor.constraint(equalToConstant: 20),
      self.pictoImageView.widthAnchor.constraint(equalTo: self.pictoImageView.heightAnchor)
    ])
    
    self.contentView.addSubview(self.titleLabel)
    NSLayoutConstraint.activate([
      self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
      self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
      self.titleLabel.leadingAnchor.constraint(equalTo: self.pictoImageView.trailingAnchor, constant: 20),
      self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
    ])
  }
  
  func configure(with viewModel: AutocompleteCellViewModel) {
    self.titleLabel.text = viewModel.label
  }
}

