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
    var characterURL = ""
    var nameCharac = ""
    var fieldName: String?
    var isLastPage = false
    func fetchCharacter(collectionView: UICollectionView) {
        NetworkManager.network.fetchCharacters(page: page) { result, empty  in
            if result.info?.next == "null" {
                self.isLastPage = true
            } else if empty == false {

                    self.results.append(contentsOf: result.results ?? [])
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
    func navigateToSection(viewController: UIViewController, index: Int) {
        let rootVC = SectionController()
        rootVC.dataResult = results[index]
        viewController.navigationController?.pushViewController(rootVC, animated: true)
    }
    func searchForFieldAndFilter(collectionView: UICollectionView) {
           if fieldName != "" {
            var searchUrl: String = ""
            if let field = fieldName {
            searchUrl = characterURL + "/?name="  + field.replacingOccurrences(of: " ", with: "%20")
            } else {
            searchUrl = characterURL + "/?name="
            }
            if !filters.isEmpty {
                searchUrl += "&" + urlWithFilters()
            }
            page = searchUrl
            self.results.removeAll()
            fetchCharacter(collectionView: collectionView)
        } else if fieldName == " " {
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
