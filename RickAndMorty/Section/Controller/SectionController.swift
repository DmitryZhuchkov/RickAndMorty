//
//  SectionController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class SectionController: UIViewController {
    var dataResult: Result?
    var persImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    func characterAttributesLabel(name: String, category: String) -> UILabel {
        let caterogyLabel: UILabel = {
            let text = UILabel()
            text.numberOfLines = 2
            let nameAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
            let statusAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            let nameText = NSMutableAttributedString(string: name + ": ", attributes: nameAttributes)
            let statusText = NSAttributedString(string: category, attributes: statusAttributes)
            nameText.append(statusText)
            text.attributedText = nameText
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        return caterogyLabel
    }
    let scrollView = UIScrollView()
    let contentView = UIView()
    override func viewDidLoad() {
        self.title = dataResult?.name
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
        self.view.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        setupScrollView()
        setupView()
        if  let imagePers = dataResult?.image {
            downloadImage(from: URL(string: imagePers)!)
        }
    }
    func setupView() {
        let name = characterAttributesLabel(name: "name", category: dataResult?.name ?? " ")
        let status = characterAttributesLabel(name: "status", category: dataResult?.status.rawValue ?? " ")
        let species = characterAttributesLabel(name: "species", category: dataResult?.species ?? " ")
        let gender = characterAttributesLabel(name: "gender", category: dataResult?.gender.rawValue ?? " ")
        let type = characterAttributesLabel(name: "type", category: dataResult?.type ?? " ")
        contentView.addSubview(persImage)
        persImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        persImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -UIScreen.main.bounds.width/9.5).isActive = true
        persImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        persImage.widthAnchor.constraint(equalTo: persImage.heightAnchor).isActive = true
        contentView.addSubview(name)
        name.topAnchor.constraint(equalTo: persImage.bottomAnchor, constant: 5).isActive = true
        name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        name.rightAnchor.constraint(equalTo: persImage.rightAnchor).isActive = true
        contentView.addSubview(status)
        status.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        status.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        status.rightAnchor.constraint(equalTo: persImage.rightAnchor).isActive = true
        contentView.addSubview(species)
        species.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 5).isActive = true
        species.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        species.rightAnchor.constraint(equalTo: persImage.rightAnchor).isActive = true
        contentView.addSubview(gender)
        gender.topAnchor.constraint(equalTo: species.bottomAnchor, constant: 5).isActive = true
        gender.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        gender.rightAnchor.constraint(equalTo: persImage.rightAnchor).isActive = true
        contentView.addSubview(type)
        type.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 5).isActive = true
        type.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        type.rightAnchor.constraint(equalTo: persImage.rightAnchor).isActive = true
        type.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.persImage.image  = UIImage(data: data)
            }
        }
    }
}
