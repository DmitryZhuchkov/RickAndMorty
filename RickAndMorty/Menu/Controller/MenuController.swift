//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 21.07.2021.
//

import UIKit

class MenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Variables
    var menuCollectionView: UICollectionView!
    var viewModel = MenuViewModel()
    var refreshControl = UIRefreshControl()
    // MARK: Collection view protocol stubs
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return CGSize(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.width/2)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.height/3.5)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
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
        case "Characters":
            let nextVC = SectionsListController()
            nextVC.baseURL = viewModel.data[indexPath.row].characters
            viewModel.navigateToList(viewController: self, secName: "Characters", rootVC: nextVC)
        default:
            viewModel.navigateToList(viewController: self, secName: cell.sectionName.text ?? "Unknow", rootVC: EmptyPage())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Navigation controller settings
        self.title = "Choose section"
        self.navigationItem.backButtonTitle = ""
        self.view.backgroundColor = UIColor(named: "Background")
        // MARK: CollectionView layout init
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // MARK: CollectionView init
        menuCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        menuCollectionView.showsHorizontalScrollIndicator = false
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.backgroundColor = UIColor(named: "Background")
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        // MARK: Collection view constaints
        view.addSubview(menuCollectionView)
        menuCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        // MARK: Fetching menu data and adding refresh control
        viewModel.fetchMenu(collectionView: menuCollectionView)
        addRefreshControl()
    }
    // MARK: RefreshControl init and animation
    func addRefreshControl() {
        guard let customView = Bundle.main.loadNibNamed("RefreshControlPickleRick", owner: nil, options: nil) else {
            return
        }
        guard let refreshView = customView[0] as? UIView else {
            return
        }
        refreshView.frame = refreshControl.frame

        refreshControl.addSubview(refreshView)
        refreshControl.tintColor = UIColor(named: "Background")
        refreshControl.backgroundColor = UIColor(named: "Background")
        refreshControl.addTarget(self, action: #selector(refreshContents), for: .valueChanged)
        refreshView.tag = 12052018
        if #available(iOS 10.0, *) {
            menuCollectionView.refreshControl = refreshControl
        } else {
            menuCollectionView.addSubview(refreshControl)
        }
    }
    @objc func refreshContents() {
        let refreshView = refreshControl.viewWithTag(12052018)
               for views in (refreshView?.subviews)! {
                       if let pickleImage = views as? UIImageView {
                           rotate(image: pickleImage)
                       }
               }
        self.perform(#selector(finishedRefreshing))
        }
      @objc func finishedRefreshing() {
        DispatchQueue.global(qos: .background).async {
            self.viewModel.fetchMenu(collectionView: self.menuCollectionView)
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
      }
    func rotate(image: UIImageView) {
            let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            image.layer.add(rotation, forKey: "rotationAnimation")
        }
}
