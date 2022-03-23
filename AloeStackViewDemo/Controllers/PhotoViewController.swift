//
//  PhotoViewController.swift
//  AloeStackViewDemo
//
//  Created by Sergey Lukaschuk on 23.03.2022.
//

import AloeStackView
import UIKit

public class PhotoViewController: AloeStackViewController {

  // MARK: Public
  public override func viewDidLoad() {
    super.viewDidLoad()
    setUpSelf()
    setUpStackView()
    setUpRows()
  }

  // MARK: Private
  private func setUpSelf() {
    title = "Photo"
  }

  private func setUpStackView() {
    stackView.hidesSeparatorsByDefault = true
  }

  private func setUpRows() {
    setUpImageRow()
  }

  private func setUpImageRow() {
    guard let image = UIImage(named: "black-cat") else { return }
    let aspectRatio = image.size.height / image.size.width

    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true

    stackView.addRow(imageView)
  }

}
