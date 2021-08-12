//
//  EmptyPage.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 26.07.2021.
//

import Foundation
import UIKit
class EmptyPage: UIViewController {
    var titleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var titleText: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        section.textColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        section.numberOfLines = 2
        section.textAlignment = .center
        return section
    }()
    override func viewDidLoad() {
        self.title = "In progress..."
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.08040765673, green: 0.09125102311, blue: 0.1102181301, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
        self.view.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        view.addSubview(titleImage)
        titleImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: UIScreen.main.bounds.height/25).isActive = true
        titleImage.image = UIImage(named:"rick_morty_PNG19")
        view.addSubview(titleText)
        titleText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: titleImage.bottomAnchor).isActive = true
        titleText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        titleText.text = "Look, Morty!\n There's nothing here!"
    }
}
