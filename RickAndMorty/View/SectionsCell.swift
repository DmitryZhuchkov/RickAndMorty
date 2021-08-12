//
//  SectionsCell.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class SectionsCell: UICollectionViewCell {
    var listName: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        section.textColor = .black
        section.textAlignment = .center
        section.backgroundColor = .clear
        return section
    }()
    var backWhite: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.5
        view.backgroundColor = .white
       
        return view
    }()
    var listImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    func config(viewModel: CharacterViewViewModel) {
        self.addSubview(listImage)
        listImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        listImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        listImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        listImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.addSubview(backWhite)
        backWhite.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backWhite.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backWhite.topAnchor.constraint(equalTo: self.centerYAnchor, constant: self.bounds.width/6 ).isActive = true
        backWhite.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.addSubview(listName)
        listName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        listName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        listName.topAnchor.constraint(equalTo: self.centerYAnchor,constant: self.bounds.width/6 ).isActive = true
        listName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        listName.text = viewModel.charac
        downloadImage(from: viewModel.imageURL)
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.listImage.image  = UIImage(data: data)
            }
        }
    }
}