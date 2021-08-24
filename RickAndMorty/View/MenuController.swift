//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 21.07.2021.
//

import UIKit

class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var menuCollectionView: UICollectionView!
    var viewModel = MenuViewModel()
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell else {
            return MenuCell.init()
        }
        if let viewModelMark = viewModel.viewModelForMark(at: indexPath.row) {
            switch indexPath.row {
            case 0:
                cell.index = 1
            case 1:
                cell.index = 2
            case 2:
                cell.index = 3
            default:
                cell.index = 4
            }
            cell.configure(viewmodel: viewModelMark)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCell else {
            return
        }
        switch cell.sectionName.text {
        case "characters":
            let nextVC = SectionsListController()
            print(viewModel.data[indexPath.row].characters)
            nextVC.baseURL = viewModel.data[indexPath.row].characters
            viewModel.navigateToList(viewController: self, secName: "characters", rootVC: nextVC)
        default:
            viewModel.navigateToList(viewController: self, secName: cell.sectionName.text ?? "unknow", rootVC: EmptyPage())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose section"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
        self.navigationItem.backButtonTitle = ""
        self.view.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        // MARK: CollectionView layout init
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // MARK: CollectionView init
        menuCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        menuCollectionView.showsHorizontalScrollIndicator = false
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuCollectionView)
        menuCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewModel.fetchMenu(collectionView: menuCollectionView)
    }
}
