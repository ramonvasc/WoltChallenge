//
//  VenueTableViewCell.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import UIKit
import SnapKit

class VenueTableViewCell: UITableViewCell {

    var viewModel: VenueCellVM

    lazy var listImageView: UIImageView = {
        let listImageView = UIImageView(frame: .zero)
        listImageView.translatesAutoresizingMaskIntoConstraints = false
        listImageView.contentMode = .scaleAspectFill
        listImageView.layer.cornerRadius = 8
        listImageView.clipsToBounds = true
        return listImageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return nameLabel
    }()

    lazy var shortDescriptionLabel: UILabel = {
        let shortDescriptionLabel = UILabel(frame: .zero)
        shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        shortDescriptionLabel.numberOfLines = 0
        shortDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        return shortDescriptionLabel
    }()

    lazy var favoritedImageView: UIImageView = {
        let favoritedImageView = UIImageView(frame: .zero)
        favoritedImageView.translatesAutoresizingMaskIntoConstraints = false
        favoritedImageView.contentMode = .scaleAspectFit
        favoritedImageView.tintColor = .black
        favoritedImageView.highlightedImage = UIImage(named: "favorite_full")?.withRenderingMode(.alwaysTemplate)
        favoritedImageView.image = UIImage(named: "favorite")?.withRenderingMode(.alwaysTemplate)
        favoritedImageView.isUserInteractionEnabled = true
        return favoritedImageView
    }()

    init(viewModel: VenueCellVM, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.viewModel = viewModel
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupViews()
        setupActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none

        listImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(nameLabel.snp.leading).inset(-16)
            make.top.bottom.equalToSuperview().inset(16)
            make.width.equalTo(80)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.bottom.equalTo(shortDescriptionLabel.snp.top)
            make.height.equalTo(shortDescriptionLabel.snp.height)
            make.trailing.equalTo(favoritedImageView.snp.leading).inset(-16)
        }

        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(listImageView.snp.trailing).inset(-16)
            make.trailing.equalTo(favoritedImageView.snp.leading).inset(-16)
        }

        favoritedImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(40)
        }
    }

    private func addViews() {
        addSubview(listImageView)
        addSubview(nameLabel)
        addSubview(shortDescriptionLabel)
        addSubview(favoritedImageView)
    }

    private func setupActions() {
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(tapFavorite))
        favoritedImageView.addGestureRecognizer(tapAction)
    }

    @objc func tapFavorite() {
        UIView.transition(with: favoritedImageView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.favoritedImageView.isHighlighted = !self.favoritedImageView.isHighlighted
        }, completion: nil)
        viewModel.saveVenueFavorite(status: favoritedImageView.isHighlighted)
    }

    func loadCell() {
        nameLabel.text = viewModel.venueName()
        shortDescriptionLabel.text = viewModel.venueDescription()
        listImageView.kf.setImage(with: URL(string: viewModel.venueImageUrl()))
        favoritedImageView.isHighlighted = viewModel.isFavorited()
    }

}

extension VenueTableViewCell: ReuseIdentifying {

    static var reuseIdentifier: String {
        return "VenueTableViewCell"
    }

}
