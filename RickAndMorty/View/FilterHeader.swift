//
//  FilterHeader.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 24.08.2021.
//

import UIKit
protocol FilterHeaderDelegate: class {
    func resetButton(tag: Int)
}

class FilterHeader: UITableViewHeaderFooterView {
    weak var delegate: FilterHeaderDelegate?
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    let headerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6630952358, green: 0.1576670706, blue: 0.2806080878, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    func config(section: Int) {
        self.tintColor = .clear
        if section == 0 {
            headerLabel.text = "Status"
        }
        if section == 1 {
            headerLabel.text =  "Gender"
        }
        headerButton.addTarget(self, action: #selector(resetButton), for: .touchUpInside)
        headerButton.tag = section
        self.addSubview(headerLabel)
        headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3).isActive = true
        self.addSubview(headerButton)
        headerButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        headerButton.bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor).isActive = true
        headerButton.topAnchor.constraint(equalTo: headerLabel.topAnchor).isActive = true
    }
    @objc func resetButton(sender: UIButton) {
        delegate?.resetButton(tag: sender.tag)
    }
}
