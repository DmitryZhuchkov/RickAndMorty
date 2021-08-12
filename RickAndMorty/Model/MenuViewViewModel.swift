//
//  MenuViewViewModel.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 23.07.2021.
//

import Foundation
final class MenuViewViewModel {
    private var menu: MenuModel
    init(menu: MenuModel) {
     self.menu = menu
    }
    var charac: String {
        let name = menu.characters
        return name
    }
    var epi: String {
        let name = menu.episodes
        return name
    }
    var loca: String {
        let name = menu.locations
        return name
    }
}
