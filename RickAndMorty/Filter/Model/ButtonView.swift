//
//  ButtonView.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 08.08.2021.
//

import Foundation
import UIKit
class ButtonView: UIButton {

  override func layoutSubviews() {
    super.layoutSubviews()
    self.setup()
  }
  // MARK: Circle button settings
  func setup() {
    self.layer.cornerRadius = self.frame.height/2
    self.layer.masksToBounds = true
  }
}
