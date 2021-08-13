//
//  SectionsListController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class SectionsListController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let padding: CGFloat = 15
           let collectionViewSize = collectionView.frame.size.width - padding
           
           return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if characterTextField.isEditing {
            print(viewModel.fieldCharacter.count)
            return viewModel.fieldCharacter.count
        } else {
            print(viewModel.results.count)
             return viewModel.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if characterTextField.isEditing {
        if !viewModel.isLastPageForField && indexPath.row == viewModel.fieldCharacter.count - 1 {
            viewModel.fetchCharacter(collectionView: sectionsList )
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionsCell", for: indexPath) as! SectionsCell
            if let viewModelMark = viewModel.viewModelForField(at: indexPath.row) {
            cell.config(viewModel: viewModelMark)
        }
        return cell
        } else {
            if !viewModel.isLastPage && indexPath.row == viewModel.results.count - 1 {
                viewModel.fetchCharacter(collectionView: sectionsList)
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionsCell", for: indexPath) as! SectionsCell
            if let viewModelMark = viewModel.viewModelForMark(at: indexPath.row) {
                cell.config(viewModel: viewModelMark)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionsCell", for: indexPath) as! SectionsCell
        viewModel.navigateToSection(viewController: self, index: indexPath.row)
    }
    
    var characterTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter name"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.autocorrectionType = UITextAutocorrectionType.no
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.keyboardType = .asciiCapable
        field.backgroundColor = #colorLiteral(red: 0.3114243746, green: 0.3254866004, blue: 0.3514238, alpha: 1)
        return field
    }()
    var sectionsList: UICollectionView!
    var viewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.08040765673, green: 0.09125102311, blue: 0.1102181301, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7113551497, green: 0.853392005, blue: 0.2492054403, alpha: 1)]
        self.navigationItem.backButtonTitle = ""
        self.view.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "xd"), style: .plain, target: self, action: #selector(filter))
        navigationItem.rightBarButtonItem?.width = 10
        
        characterTextField.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        sectionsList = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        sectionsList.showsHorizontalScrollIndicator = false
        sectionsList.dataSource = self
        sectionsList.delegate = self
        sectionsList.backgroundColor = #colorLiteral(red: 0.1379833519, green: 0.1568788886, blue: 0.1870329976, alpha: 1)
        sectionsList.register(SectionsCell.self, forCellWithReuseIdentifier: "SectionsCell")
        sectionsList.translatesAutoresizingMaskIntoConstraints = false
        if !viewModel.isLastPage {
            viewModel.fetchCharacter(collectionView: sectionsList)
        }
        
        view.addSubview(characterTextField)
        characterTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        characterTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        characterTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(sectionsList)
        sectionsList.topAnchor.constraint(equalTo: characterTextField.bottomAnchor,constant: 15).isActive = true
        sectionsList.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sectionsList.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sectionsList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.fieldName = textField.text
        viewModel.fetchFieldCharacter(collectionView: sectionsList)
          return true
      }
    func reFetchWithSelectedData(elements: [Int : String]) {
    
    }
    @objc func filter() {
        self.navigationController?.pushViewController(FilterController(), animated: true)
    }
}
