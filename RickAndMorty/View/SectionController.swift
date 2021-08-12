//
//  SectionController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class SectionController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataResult?.episode.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let cellText = dataResult?.episode[indexPath.row].replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "episode number: ")
        cell.textLabel?.text = cellText
        cell.contentView.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        return cell
    }
    
    var dataResult: Result?
    let episodesList: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
    return tableView
    }()
    var persImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    func characterAttributesLabel(name:String,category:String) -> UILabel {
        let caterogyLabel: UILabel = {
            let text = UILabel()
            let nameAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
            let statusAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 18),.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            let nameText = NSMutableAttributedString(string: name + ": ", attributes: nameAttributes)
            let statusText = NSAttributedString(string: category, attributes: statusAttributes)
            nameText.append(statusText)
            text.attributedText = nameText
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        return caterogyLabel
    }
    override func viewDidLoad() {
        self.title = dataResult?.name
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.08040765673, green: 0.09125102311, blue: 0.1102181301, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
        self.view.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        let name = characterAttributesLabel(name: "name", category: dataResult?.name ?? " ")
        let status = characterAttributesLabel(name: "status", category: dataResult?.status.rawValue ?? " ")
        let species = characterAttributesLabel(name: "species", category: dataResult?.species ?? " ")
        let gender = characterAttributesLabel(name: "gender", category: dataResult?.gender.rawValue ?? " ")
        let type = characterAttributesLabel(name: "type", category: dataResult?.type ?? " ")
        // MARK: Table view init
        episodesList.dataSource = self
        episodesList.delegate = self
        
        view.addSubview(persImage)
        persImage.leftAnchor.constraint(equalTo: view.leftAnchor,constant: UIScreen.main.bounds.width/9.5).isActive = true
        persImage.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -UIScreen.main.bounds.width/9.5).isActive = true
        persImage.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        persImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.addSubview(name)
        name.topAnchor.constraint(equalTo: view.centerYAnchor,constant: 5).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        view.addSubview(status)
        status.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 5).isActive = true
        status.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        view.addSubview(species)
        species.topAnchor.constraint(equalTo: status.bottomAnchor,constant: 5).isActive = true
        species.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        view.addSubview(gender)
        gender.topAnchor.constraint(equalTo: species.bottomAnchor,constant: 5).isActive = true
        gender.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        view.addSubview(type)
        type.topAnchor.constraint(equalTo: gender.bottomAnchor,constant: 5).isActive = true
        type.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        view.addSubview(episodesList)
        episodesList.topAnchor.constraint(equalTo: type.bottomAnchor,constant: 5).isActive = true
        episodesList.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width/9.5).isActive = true
        episodesList.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width/9.5).isActive = true
        episodesList.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 5).isActive = true
        episodesList.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        if  let imagePers = dataResult?.image  {
            downloadImage(from: URL(string:imagePers)!)
        }
        
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.persImage.image  = UIImage(data: data)
            }
        }
    }
}
