//
//  MenuCell.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 21.07.2021.
//

import Foundation
import UIKit
class MenuCell: UICollectionViewCell {
    // MARK: Outlets init
    var sectionName: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        section.textColor = UIColor(named: "Background")
        section.textAlignment = .center
        return section
    }()
    var sectionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.4
        return image
    }()
    var index: Int = 4
    func configure(viewmodel: MenuViewViewModel) {
        // MARK: Cell settings
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor(named: "SectionTextColor")
        // MARK: Constaints
        self.addSubview(sectionImage)
        sectionImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sectionImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sectionImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sectionImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.addSubview(sectionName)
        sectionName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sectionName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sectionName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sectionName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // MARK: Cell configuration case
        switch index {
        case 1:
            sectionName.text = "Characters"
            sectionImage.image = UIImage(named: "rick-and-morty-lede-1300x813")
        case 2:
            sectionName.text = "Locations"
            sectionImage.image = UIImage(named: "rick-and-morty-screaming-sun-1024x475")
        case 3:
            sectionName.text = "Episodes"
            sectionImage.image = UIImage(named: "2_1911181156166-rickandmorty_403_dup-20191115")
        default:
            sectionName.text = "Unknown"
            sectionImage.image = UIImage(named: "rick_morty_PNG19")
        }
    }
}
