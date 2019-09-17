//
//  VenueViewController.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class VenueViewController: UIViewController {

    var viewModel: VenueVM

    init(viewModel: VenueVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VenueTableViewCell.self, forCellReuseIdentifier: VenueTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupViews()
        viewModel.fetchVenues()
    }

    private func addViews() {
        view.addSubview(tableView)
    }

    private func setupViews() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.reloadData()
    }

}

extension VenueViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.venues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = VenueCellVM(coreDataManager: CoreDataManager(), venue: viewModel.venues[indexPath.row])
        let cell = VenueTableViewCell(viewModel: cellViewModel, style: .default, reuseIdentifier: VenueTableViewCell.reuseIdentifier)
        cell.loadCell()
        return cell
    }

}

extension VenueViewController: VenuesFetchDelegate {

    func didFetchResults() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func didFailToFetchResults() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "No venues were found around here", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self?.tableView.reloadData()
            }))
            self?.present(alert, animated: true)
        }
    }

}
