//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 25.07.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class CharacterViewModel {
    // MARK: Variables
    var filters = [Int: String]()
    var results: [Result] = []
    var fieldCharacter: [Result] = []
    var page = ""
    var characterURL = ""
    var nameCharac = ""
    var fieldName: String?
    var isLastPage = false
    private let appService: NetworkManager
    private let disposeBag = DisposeBag()
    init(appService: NetworkManager) {
         self.appService = appService

     }
     
     private let _characters = BehaviorRelay<[Result]>(value: [])
     private let _isFetching = BehaviorRelay<Bool>(value: false)
     private let _error = BehaviorRelay<String?>(value: nil)
   
     var isFetching: Driver<Bool> {
         return _isFetching.asDriver()
     }
     
     var characters: Driver<[Result]> {
         return _characters.asDriver()
     }
     
     var error: Driver<String?> {
         return _error.asDriver()
     }
     
     var hasError: Bool {
         return _error.value != nil
     }
     var numberOfCharactres: Int {
         return _characters.value.count
     }
     
     func viewModelForHero(at index: Int) -> CharacterViewViewModel? {
         guard index < _characters.value.count else {
             return nil
         }
         return CharacterViewViewModel(character: _characters.value[index])
     }
 // MARK: Fetch heroes from internet
     func fetchHeroes() {
         self._characters.accept([])
         self._isFetching.accept(true)
         self._error.accept(nil)
         NetworkManager.network.fetchCharacters(page: page, completionHandler: { [weak self] response,empty  in
             if response.infoForPage?.next == "null" {
                 self?.isLastPage = true
             } else if empty == false {
                 self?._characters.accept(response.resultsForCharacter ?? [])
             }
             if empty == false {
                 self?.page = response.infoForPage?.next ?? "null"
             }
      })
     }
    // MARK: Pushing to section VC method
    func navigateToSection(viewController: UIViewController, index: Int) {
        let rootVC = SectionController()
        rootVC.dataResult = results[index]
        viewController.navigationController?.pushViewController(rootVC, animated: true)
    }
    // MARK: Searching for using field and filter case
    func searchForFieldAndFilter() {
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
            fetchHeroes()
        } else if fieldName == " " {
        }
    }
    // MARK: URL preparation
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
