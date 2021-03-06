//
//  SectionsListController.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 22.07.2021.
//

import Foundation
import UIKit
class SectionsListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    // MARK: Collection view protocol stubs
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceSize = UIScreen.main.bounds.size
            let padding: CGFloat = 15
        if deviceSize.width > deviceSize.height {
            let collectionViewSize = deviceSize.height - padding
                    return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        } else {
            let collectionViewSize = deviceSize.width - padding
                    return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        }

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if !viewModel.isLastPage && indexPath.row == viewModel.results.count - 1 {
                viewModel.fetchCharacter(collectionView: sectionsList)
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionsCell", for: indexPath) as? SectionsCell else {
                return SectionsCell.init()
            }
            if let viewModelMark = viewModel.viewModelForMark(at: indexPath.row) {
                cell.config(viewModel: viewModelMark)
            }
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToSection(viewController: self, index: indexPath.row)
    }
    // MARK: Text Field init
    var characterTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter name"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = UIColor(named: "SectionTextColor")
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.autocorrectionType = UITextAutocorrectionType.no
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.keyboardType = .asciiCapable
        field.backgroundColor = UIColor(named: "Background")
        field.clearButtonMode = .never
        field.resignFirstResponder()
        return field
    }()
    // MARK: Variables
    let filterController = FilterController()
    var baseURL: String?
    var sectionsList: UICollectionView!
    var viewModel = CharacterViewModel()
    var filterViewModel = FilterViewModel()
    override func viewDidLoad() {
        viewModel.characterURL = baseURL ?? " "
        filterController.delegate = self
        characterTextField.delegate = self
        // MARK: Navigation controller settings
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor")!]
        self.navigationItem.backButtonTitle = ""
        self.view.backgroundColor = UIColor(named: "Background")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "xd"), style: .plain, target: self, action: #selector(filter))
        navigationItem.rightBarButtonItem?.width = 10
        // MARK: Collection view settings
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        sectionsList = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        sectionsList.showsHorizontalScrollIndicator = false
        sectionsList.dataSource = self
        sectionsList.delegate = self
        sectionsList.backgroundColor = UIColor(named: "Background")
        sectionsList.register(SectionsCell.self, forCellWithReuseIdentifier: "SectionsCell")
        sectionsList.translatesAutoresizingMaskIntoConstraints = false
        viewModel.searchForFieldAndFilter(collectionView: sectionsList)
        setupView()
    }
    func setupView() {
        // MARK: Constaints
        view.addSubview(characterTextField)
        characterTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        characterTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        characterTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        view.addSubview(sectionsList)
        sectionsList.topAnchor.constraint(equalTo: characterTextField.bottomAnchor, constant: 15).isActive = true
        sectionsList.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2).isActive = true
        sectionsList.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -2).isActive = true
        sectionsList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    // MARK: Text field method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                 let textRange = Range(range, in: text) {
                 if string == "\n" {
                 viewModel.fieldName = text.replacingCharacters(in: textRange, with: " ")
                 } else {
                    viewModel.fieldName = text.replacingCharacters(in: textRange, with: string)
                 }
                 viewModel.searchForFieldAndFilter(collectionView: sectionsList)
              }
        return true
    }
    // MARK: Pushing to filter controller method
    @objc func filter() {
        let filterController = FilterController()
        filterController.delegate = self
        filterController.selectedItem = viewModel.filters
        self.navigationController?.pushViewController(filterController, animated: true)
    }
}
// MARK: Filter controller protocol stub
extension SectionsListController: FilterControllerDelegate {
    func searchWithFilter(selected: [Int: String]) {
        viewModel.filters = selected
        viewModel.searchForFieldAndFilter(collectionView: sectionsList)
        }
}
