//
//  JsonLoad.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 21.07.2021.
//

import Foundation
class NetworkManager {
    static let network = NetworkManager()
    var emptyResult: Character?
    // MARK: Fetching menu
    func fetchMenu(completionHandler: @escaping (_ response: MenuModel) -> Void) {
        let baseURL = URL(string: Constant.shared.baseURL)!
        let task = URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(MenuModel.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(results)
                    }
                } catch {
                    print("error decoding data: \(error)")
                }
            }
        }
        task.resume()
    }
    // MARK: Fetching characters
    func fetchCharacters(page: String = "", completionHandler: @escaping (_ response: Character, _ isEmpty: Bool) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: page)!) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    return
                }
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(Character.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(results, false)
                    }
                } catch {
                    print("error decoding data: \(error)")
                }
            }
        }
        task.resume()
    }
}
