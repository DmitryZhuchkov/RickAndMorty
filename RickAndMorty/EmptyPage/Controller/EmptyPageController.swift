//
//  EmptyPage.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 26.07.2021.
//

import Foundation
import UIKit
class EmptyPage: UIViewController {
    // MARK: Outlets init
    var titleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var titleText: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        section.textColor = UIColor(named: "TextColor")
        section.numberOfLines = 2
        section.textAlignment = .center
        return section
    }()
    override func viewDidLoad() {
        // MARK: Navigation controller settings
        self.title = "In progress..."
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor")!]
        self.view.backgroundColor = UIColor(named: "Background")
        // MARK: Constaints
        view.addSubview(titleImage)
        titleImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleImage.widthAnchor.constraint(equalTo: titleImage.heightAnchor).isActive = true
        titleImage.image = UIImage(named: "rick_morty_PNG19")
        view.addSubview(titleText)
        titleText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: titleImage.bottomAnchor).isActive = true
        titleText.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        titleText.text = "Look, Morty!\n There's nothing here!"
    }
}
