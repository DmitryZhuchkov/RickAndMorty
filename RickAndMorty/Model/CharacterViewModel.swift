//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 25.07.2021.
//

import Foundation
import UIKit
class CharacterViewModel {
    var filters = [Int: String]()
    var results: [Result] = []
    var fieldCharacter: [Result] = []
    var page = ""
    var nameCharac = ""
    var fieldName: String?
    var flagForFilter: Bool?
    var isLastPage = false
    var isLastPageForField = false
    var fetchingWithFilter: Bool = false
    func fetchCharacter(collectionView: UICollectionView) {
        print(page, "!!!!!")
        NetworkManager.network.fetchCharacters(page: page) { result, empty  in
            if result.info?.next == "null" {
                if self.fetchingWithFilter == false {
                self.isLastPage = true
                } else {
                    self.isLastPageForField = true
                }
            } else if empty == false {
                if self.fetchingWithFilter == false {
                    self.results.append(contentsOf: result.results ?? [])
                } else {
                    print("!!!")
                    self.fieldCharacter.append(contentsOf: result.results ?? [])
                }
            }
            if empty == false {
            self.page = result.info?.next ?? "null"
            }
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
     }
    }
    // MARK: Data checking
       func viewModelForMark(at index: Int) -> CharacterViewViewModel? {
        guard index < results.count else {
                   return nil
               }
        return CharacterViewViewModel(character: results[index]  )
           }
    // MARK: Data checking
       func viewModelForField(at index: Int) -> CharacterViewViewModel? {
        guard index < fieldCharacter.count else {
                   return nil
               }
        return CharacterViewViewModel(character: fieldCharacter[index]  )
           }
    func navigateToSection(viewController: UIViewController, index: Int) {
        let rootVC = SectionController()
        if fieldCharacter.isEmpty {
        rootVC.dataResult = results[index]
        } else {
        rootVC.dataResult = fieldCharacter[index]
        }
        viewController.navigationController?.pushViewController(rootVC, animated: true)
    }
    func searchForFieldAndFilter(for collectionView: UICollectionView) {
           if fieldName != "" {
            fetchingWithFilter = true
            var searchUrl: String = ""
            if let field = fieldName {
            searchUrl = Constant.shared.nameURL + "/?name="  + field.replacingOccurrences(of: " ", with: "%20")
            } else {
            searchUrl = Constant.shared.nameURL + "/?name="
            }
            if !filters.isEmpty {
                searchUrl += "&" + urlWithFilters()
            }
            page = searchUrl
            self.fieldCharacter.removeAll()
            fetchCharacter(collectionView: collectionView)
        } else {
            fetchingWithFilter = false
        }
    }
    func urlWithFilters() -> String {
        var statusString = ""
        var genderString = ""
        if let status = filters[0] {
            statusString = "status=" + status
        } else {
             statusString = ""
        }
        if let gender = filters[1] {
            genderString = "gender=" + gender
        } else {
            genderString = ""
        }
        return "&" + statusString + "&" + genderString
    }
}
