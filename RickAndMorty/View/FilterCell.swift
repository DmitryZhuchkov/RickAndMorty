//
//  FilterCell.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 06.08.2021.
//

import Foundation
import UIKit
protocol FilterCellDelegate: class {
    func didToggleRadioButton(_ indexPath: IndexPath)
}

class FilterCell: UITableViewCell {
    weak var delegate: FilterCellDelegate?
    var categoryName: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        section.numberOfLines = 1
        section.textColor = .white
        section.textAlignment = .center
        section.backgroundColor = .clear
        return section
    }()
    var categoryButton: UIButton = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    func initCellItem() {
        self.contentView.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        self.addSubview(categoryButton)
        categoryButton.leftAnchor.constraint(equalTo: self.leftAnchor ).isActive = true
        categoryButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryButton.bottomAnchor.constraint(equalTo: self.bottomAnchor ).isActive = true
        categoryButton.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -5).isActive = true
        categoryButton.widthAnchor.constraint(equalTo: categoryButton.heightAnchor).isActive = true
        self.addSubview(categoryName)
        categoryName.leftAnchor.constraint(equalTo: categoryButton.rightAnchor, constant: 10).isActive = true
        categoryName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        categoryButton.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
    }
    @objc func radioButtonTapped(_ radioButton: UIButton) {
        let isSelected = !self.categoryButton.isSelected
        self.categoryButton.isSelected = isSelected
        if isSelected {
            categoryName.textColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
            categoryButton.backgroundColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
            self.setSelected(true, animated: false)
            deselectOtherButton()
        }
        guard let tableView = self.superview as? UITableView else {
            return }
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        delegate?.didToggleRadioButton(tappedCellIndexPath)
    }
    func deselectOtherButton() {
        let tableView = self.superview as? UITableView
        let tappedCellIndexPath = tableView?.indexPath(for: self)!
        let indexPaths = tableView?.indexPathsForVisibleRows
        for indexPath in indexPaths! {
            if indexPath.row != tappedCellIndexPath?.row && indexPath.section == tappedCellIndexPath?.section {
                guard let cell = tableView?.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? FilterCell else {
                    return
                }
                cell.categoryButton.isSelected = false
                cell.categoryButton.backgroundColor = .white
                cell.categoryName.textColor = .white
            }
        }
    }
    func cellSelected() {
        self.setSelected(true, animated: false)
        categoryName.textColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        categoryButton.backgroundColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
    }
    func resetButton() {
        self.categoryButton.isSelected = false
        self.categoryButton.backgroundColor = .white
        self.categoryName.textColor = .white
    }
}
