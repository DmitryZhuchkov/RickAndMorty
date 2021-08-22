//
//  FilterController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit

protocol FilterControllerDelegate: class {
    func searchWithFilter(selected: [Int: String])
}

class FilterController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterCellDelegate {
    func numberOfSections( in tableView: UITableView) -> Int {
        return viewModel.menuList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuList[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FilterCell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterCell else {
            return FilterCell.init()
        }
        let item = viewModel.menuList[indexPath.section][indexPath.row]
        if !selectedItem.isEmpty {
            if item == selectedItem[indexPath.section] {
                cell.cellSelected()
            }
        }
        cell.categoryName.text = item
        cell.initCellItem()
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        // code for adding centered title
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        headerLabel.textColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        if section == 0 {
            headerLabel.text = "Status"
        }
        if section == 1 {
            headerLabel.text =  "Gender"
        }
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        // code for adding button to right corner of section header
        let headerResetButton: UIButton = UIButton(frame: CGRect(x: headerView.frame.size.width - 95, y: 0, width: 100, height: 28))
        headerResetButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        headerResetButton.setTitle("Reset", for: .normal)
        headerResetButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        headerResetButton.addTarget(self, action: #selector(resetButton), for: .touchUpInside)
        headerResetButton.tag = section
        headerView.addSubview(headerResetButton)
        return headerView
    }
    var viewModel = FilterViewModel()
    weak var delegate: FilterControllerDelegate?
    var selectedItem = [Int: String]()
    let filterList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilterCell.self, forCellReuseIdentifier: "filterCell")
        tableView.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        return tableView
    }()
    let applyButton: UIButton = {
        let apply = UIButton()
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        apply.setTitleColor(#colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1), for: .normal)
        apply.setTitle("Apply Filters", for: .normal)
        apply.backgroundColor = .none
        apply.layer.cornerRadius = 10
        apply.layer.masksToBounds = true
        apply.layer.borderWidth = 1
        apply.layer.borderColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        return apply
    }()
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.08040765673, green: 0.09125102311, blue: 0.1102181301, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
        self.view.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        applyButton.addTarget(self, action: #selector(applyChanges), for: .touchUpInside)
        filterList.dataSource = self
        filterList.delegate = self
        setupView()
    }
    func setupView() {
        view.addSubview(filterList)
        filterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterList.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        filterList.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width/9.5).isActive = true
        view.addSubview(applyButton)
        applyButton.topAnchor.constraint(equalTo: filterList.bottomAnchor, constant: UIScreen.main.bounds.height/9.5).isActive = true
        applyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/12).isActive = true
        applyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width/12).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.main.bounds.height/25).isActive = true
    }
    @objc func applyChanges() {
        delegate?.searchWithFilter(selected: selectedItem)
        navigationController?.popViewController(animated: true)
    }
    func didToggleRadioButton(_ indexPath: IndexPath) {
        let section = indexPath.section
        let data = viewModel.menuList[section][indexPath.row]
        if let previousItem = selectedItem[section] {
            if previousItem == data {
                selectedItem.removeValue(forKey: section)
                return
            }
        }
        selectedItem.updateValue(data, forKey: section)
    }
    @objc func resetButton(sender: UIButton) {
        for cell in 0...viewModel.menuList[sender.tag].count-1 {
            let indexPath: IndexPath = [sender.tag, cell]
            if filterList.cellForRow(at: indexPath)?.isSelected == true {
                guard let cell = filterList.cellForRow(at: indexPath) as? FilterCell else {
                    return
                }
                cell.resetButton()
                selectedItem.removeValue(forKey: sender.tag)
            }
        }
    }
}
