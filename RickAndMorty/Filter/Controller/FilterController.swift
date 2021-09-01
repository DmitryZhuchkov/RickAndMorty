//
//  FilterController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit

// MARK: Filter protocol
protocol FilterControllerDelegate: class {
    func searchWithFilter(selected: [Int: String])
}

class FilterController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterHeaderDelegate, FilterCellDelegate {
    // MARK: TableView protocol stubs
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
        guard let headerView: FilterHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FilterHeader") as? FilterHeader else {
            return FilterHeader.init()
        }
        headerView.config(section: section)
        if !(selectedItem[section]?.isEmpty ?? true) {
            headerView.headerButton.setTitleColor(#colorLiteral(red: 0.9664108157, green: 0.1161905304, blue: 0.3387114406, alpha: 1), for: .normal)
        } else {
            headerView.headerButton.setTitleColor(#colorLiteral(red: 0.6630952358, green: 0.1576670706, blue: 0.2806080878, alpha: 1), for: .normal)
        }
        headerView.delegate = self
        return headerView
    }
    var viewModel = FilterViewModel()
    weak var delegate: FilterControllerDelegate?
    var selectedItem = [Int: String]()
    // MARK: Outlets init
    let filterList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilterCell.self, forCellReuseIdentifier: "filterCell")
        tableView.backgroundColor = UIColor(named: "Background")
        tableView.separatorStyle = .none
        return tableView
    }()
    let applyButton: UIButton = {
        let apply = UIButton()
        apply.translatesAutoresizingMaskIntoConstraints = false
        apply.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        apply.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        apply.setTitle("Apply Filters", for: .normal)
        apply.backgroundColor = .none
        apply.layer.cornerRadius = 10
        apply.layer.masksToBounds = true
        apply.layer.borderWidth = 1
        apply.layer.borderColor = UIColor(named: "TextColor")?.cgColor
        return apply
    }()
    override func viewDidLoad() {
        // MARK: Navigation controller settings
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor")!]
        self.view.backgroundColor = UIColor(named: "Background")
        applyButton.addTarget(self, action: #selector(applyChanges), for: .touchUpInside)
        // MARK: TableView settings
        filterList.dataSource = self
        filterList.delegate = self
        filterList.register(FilterHeader.self, forHeaderFooterViewReuseIdentifier: "FilterHeader")
        setupView()
    }
    func setupView() {
        // MARK: Constaints
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
    // MARK: Apply button method
    @objc func applyChanges() {
        delegate?.searchWithFilter(selected: selectedItem)
        navigationController?.popViewController(animated: true)
    }
   // MARK: Protocol FilterCell stubs realize
    func didToggleRadioButton(_ indexPath: IndexPath) {
        let section = indexPath.section
        guard let header = filterList.headerView(forSection: section) as? FilterHeader else {
        return
        }
        let data = viewModel.menuList[section][indexPath.row]
        if let previousItem = selectedItem[section] {
            if previousItem == data {
                selectedItem.removeValue(forKey: section)
            }
        }
        selectedItem.updateValue(data, forKey: section)
        header.headerButton.setTitleColor(#colorLiteral(red: 0.9664108157, green: 0.1161905304, blue: 0.3387114406, alpha: 1), for: .normal)
    }
    func resetButton(tag: Int) {
        for cell in 0...viewModel.menuList[tag].count-1 {
            let indexPath: IndexPath = [tag, cell]
            guard let header = filterList.headerView(forSection: tag) as? FilterHeader else {
            return
            }
            guard let cell = filterList.cellForRow(at: indexPath) as? FilterCell else {
                return
            }
            if cell.categoryName.text == selectedItem[tag] {
                cell.resetButton()
                selectedItem.removeValue(forKey: tag)
                header.headerButton.setTitleColor(#colorLiteral(red: 0.6630952358, green: 0.1576670706, blue: 0.2806080878, alpha: 1), for: .normal)
            }
        }
    }
}
