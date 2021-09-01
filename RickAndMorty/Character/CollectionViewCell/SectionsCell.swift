//
//  SectionsCell.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class SectionsCell: UICollectionViewCell {
    // MARK: Outlets init
    var listName: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        section.textColor = UIColor(named: "Background")
        section.textAlignment = .center
        section.backgroundColor = .clear
        return section
    }()
    var backWhite: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.5
        view.backgroundColor = UIColor(named: "SectionTextColor")
        return view
    }()
    var listImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    func config(viewModel: CharacterViewViewModel) {
        // MARK: Cell outlets settings
        listName.text = viewModel.charac
        downloadImage(from: viewModel.imageURL)
        // MARK: Constaints
        self.addSubview(listImage)
        listImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        listImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        listImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        listImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.addSubview(backWhite)
        backWhite.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backWhite.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backWhite.topAnchor.constraint(equalTo: listImage.centerYAnchor, constant: self.bounds.height*0.25).isActive = true
        backWhite.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.addSubview(listName)
        listName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        listName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        listName.topAnchor.constraint(equalTo: listImage.centerYAnchor, constant: self.bounds.height*0.25).isActive = true
        listName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // MARK: Cell settings
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    // MARK: Downloading image from URL methods
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, _, error in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self?.listImage.image  = UIImage(data: data)
                }
            }
        }
    }
}
