//
//  FilterCell.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 06.08.2021.
//

import Foundation
import UIKit
// MARK: Filter cell protocol
protocol FilterCellDelegate: class {
    func didToggleRadioButton(_ indexPath: IndexPath)
}

class FilterCell: UITableViewCell {
    weak var delegate: FilterCellDelegate?
    // MARK: Outlets init
    var categoryName: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        section.numberOfLines = 1
        section.textColor = UIColor(named: "SectionTextColor")
        section.textAlignment = .center
        section.backgroundColor = .clear
        return section
    }()
    var categoryButton: UIButton = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "SectionTextColor")
        return button
    }()
    // MARK: Cell constaints and methods init
    func initCellItem() {
        self.contentView.backgroundColor = UIColor(named: "Background")
        self.addSubview(categoryButton)
        categoryButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        categoryButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryButton.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -5).isActive = true
        categoryButton.widthAnchor.constraint(equalTo: categoryButton.heightAnchor).isActive = true
        self.addSubview(categoryName)
        categoryName.leftAnchor.constraint(equalTo: categoryButton.rightAnchor, constant: 10).isActive = true
        categoryName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        categoryButton.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
    }
    // MARK: Cell tapped method
    @objc func radioButtonTapped(_ radioButton: UIButton) {
        let isSelected = !self.categoryButton.isSelected
        self.categoryButton.isSelected = isSelected
        if isSelected {
            categoryName.textColor = UIColor(named: "TextColor")
            categoryButton.backgroundColor = UIColor(named: "TextColor")
            self.setSelected(true, animated: false)
            deselectOtherButton()
        }
        guard let tableView = self.superview as? UITableView else {
            return }
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        delegate?.didToggleRadioButton(tappedCellIndexPath)
    }
    // MARK: Deselecting other cell method
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
                cell.categoryButton.backgroundColor = UIColor(named: "SectionTextColor")
                cell.categoryName.textColor = UIColor(named: "SectionTextColor")
            }
        }
    }
    // MARK: Cell selected method
    func cellSelected() {
        categoryName.textColor = UIColor(named: "TextColor")
        categoryButton.backgroundColor =  UIColor(named: "TextColor")
    }
    // MARK: Reset button tapped
    func resetButton() {
        self.categoryButton.isSelected = false
        self.categoryButton.backgroundColor = .white
        self.categoryName.textColor = .white
    }
}
