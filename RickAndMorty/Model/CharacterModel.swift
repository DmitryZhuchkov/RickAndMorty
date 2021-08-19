//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 25.07.2021.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let info: Info?
    let results: [Result]?
    enum CodingKeys: String, CodingKey {
            case info = "info"
            case results = "results"
        }
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
