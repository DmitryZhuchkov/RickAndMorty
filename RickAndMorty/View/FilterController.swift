//
//  FilterController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class FilterController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterCellDelegate {
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FilterCell =
          tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterCell
           let item = menuList[indexPath.section][indexPath.row]
           cell.categoryName.text = item
           if item == selectedElement[indexPath.section] {
               cell.categoryButton.isSelected = true
           } else {
               cell.categoryButton.isSelected = false
           }
           cell.initCellItem()
           cell.delegate = self
           return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
         // code for adding centered title
         let headerLabel = UILabel(frame: CGRect(x: -140, y: 0, width:
             tableView.bounds.size.width, height: 28))
         headerLabel.textColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        if section == 0{
           headerLabel.text = "Status"
              }
        if section == 1{
           headerLabel.text =  "Gender"
              }
         headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
         headerLabel.textAlignment = .center
         headerView.addSubview(headerLabel)

         // code for adding button to right corner of section header
         let showHideButton: UIButton = UIButton(frame: CGRect(x:headerView.frame.size.width - 95, y:0, width:100, height:28))
         showHideButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
         showHideButton.setTitle("Reset", for: .normal)
         showHideButton.setTitleColor(#colorLiteral(red: 1, green: 0.107677646, blue: 0.3452052772, alpha: 1), for: .normal)
         showHideButton.addTarget(self, action: #selector(resetButton), for: .touchUpInside)
        showHideButton.tag = section
         headerView.addSubview(showHideButton)

         return headerView
    }
    var viewModel = CharacterViewModel()
    let menuList = [ ["Alive", "Dead","Unknown"],
    ["Female", "Male", "Genderless","unknown"] ]
    var selectedElement = [Int : String]()
    var indexForReset: IndexPath?
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
        
        filterList.dataSource = self
        filterList.delegate = self

        view.addSubview(filterList)
        filterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filterList.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        filterList.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width/9.5).isActive = true
        
        view.addSubview(applyButton)
        applyButton.topAnchor.constraint(equalTo: filterList.bottomAnchor,constant: UIScreen.main.bounds.height/9.5).isActive = true
        applyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/12).isActive = true
        applyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width/12).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -UIScreen.main.bounds.height/25).isActive = true
    }
    func didToggleRadioButton(_ indexPath: IndexPath) {
        let section = indexPath.section
        let data = menuList[section][indexPath.row]
        if let previousItem = selectedElement[section] {
            if previousItem == data {
                selectedElement.removeValue(forKey: section)
                print(section)
                return
            }
        }
        selectedElement.updateValue(data, forKey: section)
    }
    @objc func resetButton(sender:UIButton) {
        print(sender.tag)
        selectedElement.removeValue(forKey: sender.tag)
//        let tappedCellIndexPath = filterList.indexPath(for: FilterCell)!
//        let indexPaths = filterList.indexPathsForVisibleRows
//        for indexPath in indexPaths! {
//            if indexPath.row != tappedCellIndexPath?.row && indexPath.section == tappedCellIndexPath?.section {
//                let cell = filterList.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! FilterCell
//                cell.categoryButton.isSelected = false
//                cell.categoryButton.backgroundColor = .white
//                cell.categoryName.textColor = .white
//            }
//        }
    }
}
