//
//  MenuViewModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 24.07.2021.
//

import Foundation
import UIKit
class MenuViewModel {
    var data: [MenuModel] = []
    // MARK: Fetcing menu method
    func fetchMenu(collectionView: UICollectionView) {
        NetworkManager.network.fetchMenu { result in
            self.data = [result]
            self.data.append(contentsOf: [result])
            self.data.append(contentsOf: [result])
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
    // MARK: Data checking method
    func viewModelForMark(at index: Int) -> MenuViewViewModel? {
        guard index < data.count else {
            return nil
        }
        return MenuViewViewModel(menu: data[index])
    }
    // MARK: Pushing to next controller method
    func navigateToList(viewController: UIViewController, secName: String, rootVC: UIViewController) {
        rootVC.title = secName
        viewController.navigationController?.pushViewController(rootVC, animated: true)
    }
}
