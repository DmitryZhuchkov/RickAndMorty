//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 25.07.2021.
//

import Foundation
import UIKit
class CharacterViewModel {
    var results: [Result] = []
    var fieldCharacter: [Result] = []
    var page = ""
    let nameURL = "https://rickandmortyapi.com/api/character/?name="
    var nameCharac = "https://rickandmortyapi.com/api/character/?name="
    var fieldName:String?
    var isLastPage = false
    var isLastPageForField = false
    func fetchCharacter(collectionView:UICollectionView) {        
        NetworkManager.network.fetchCharacters(page: page) { result in
            if result.info.next == "null"  {
                if self.fieldCharacter.isEmpty {
                self.isLastPage = true
                } else {
                    self.isLastPageForField = true
                }
            } else {
                if self.fieldCharacter.isEmpty{
                self.results.append(contentsOf: result.results)
                } else {
                self.fieldCharacter.append(contentsOf: result.results)
                }
            }
            self.page = result.info.next ?? "null"
            print(self.page)
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
    func navigateToSection(viewController:UIViewController,index: Int) {
        let rootVC = SectionController()
        if fieldCharacter.isEmpty {
        rootVC.dataResult = results[index]
        } else {
        rootVC.dataResult = fieldCharacter[index]
        }
        viewController.navigationController?.pushViewController(rootVC, animated: true)
        
    }
    
    func fetchFieldCharacter(collectionView:UICollectionView) {
        nameCharac = nameURL + (fieldName ?? "")
        print(nameCharac)
        isLastPageForField = false
        fieldCharacter.removeAll()
        NetworkManager.network.fetchCharacters(page: nameCharac) { result in
            if result.info.next == "null" {
                self.isLastPageForField = true
            } else {
                self.fieldCharacter =  result.results
            }
            self.page = result.info.next ?? "null"
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
     }
    }
}
