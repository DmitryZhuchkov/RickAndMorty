//
//  CharacterViewViewModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 25.07.2021.
//

import Foundation
final class CharacterViewViewModel {
    private var character: Result
    init(character: Result) {
        self.character = character
    }
    // MARK: Variable inits
    var charac: String {
        let name = character.name
        return name
    }
    var imageURL: URL {
        let urlString = character.image
        return URL(string: urlString)!
    }
    var status: String {
        let status = character.status
        return status.rawValue
    }
    var species: String {
        let species = character.species
        return species
    }
    var gender: String {
        let gender = character.gender
        return gender.rawValue
    }
    var type: String {
        let type = character.type
        return type
    }
}
