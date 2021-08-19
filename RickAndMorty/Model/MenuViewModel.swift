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
    // MARK: Data checking
       func viewModelForMark(at index: Int) -> MenuViewViewModel? {
           guard index < data.count else {
                   return nil
               }
        return MenuViewViewModel(menu: data[index])
           }
    func navigateToList(viewController: UIViewController, secName: String, rootVC: UIViewController) {
        rootVC.title = secName
        viewController.navigationController?.pushViewController(rootVC, animated: true)

    }
}
