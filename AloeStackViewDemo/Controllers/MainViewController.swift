//
//  MainViewController.swift
//  AloeStackViewDemo
//
//  Created by Sergey Lukaschuk on 23.03.2022.
//

import AloeStackView
import UIKit

public class MainViewController: AloeStackViewController {

  // MARK: Public
  public override func viewDidLoad() {
    super.viewDidLoad()
    setUpSelf()
    setUpStackView()
    setUpRows()
  }

  // MARK: Private
  private func setUpSelf() {
    title = "AloeStackView Demo"
  }

  private func setUpStackView() {
    stackView.automaticallyHidesLastSeparator = true
  }

  private func setUpRows() {
    setUpDescriptionRow()
    setUpSwitchRow()
    setUpHiddenRows()
    setUpExpandingRowView()
    setUpHorizontalRow()
    setUpPhotoRow()
  }

  private func setUpDescriptionRow() {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.text = "This simple app shows some ways you can use AloeStackView to lay out a screen in your app."
    stackView.addRow(label)
  }

  private func setUpSwitchRow() {
    let switchRow = SwitchRowView()
    switchRow.text = "Show and hide rows with animation"
    switchRow.switchDidChange = { [weak self] isOn in
      guard let self = self else { return }
      self.stackView.setRowsHidden(self.hiddenRows, isHidden: !isOn, animated: true)
    }
    stackView.addRow(switchRow)
  }

  private let hiddenRows = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]

  private func setUpHiddenRows() {
    for (index, row) in hiddenRows.enumerated() {
      row.font = UIFont.preferredFont(forTextStyle: .caption2)
      row.text = "Hidden row " + String(index + 1)
    }

    stackView.addRows(hiddenRows)
    stackView.hideRows(hiddenRows)

    let rowInset = UIEdgeInsets(
      top: stackView.rowInset.top,
      left: stackView.rowInset.left * 2,
      bottom: stackView.rowInset.bottom,
      right: stackView.rowInset.right)

    let separatorInset = UIEdgeInsets(
      top: 0,
      left: stackView.separatorInset.left * 2,
      bottom: 0,
      right: 0)

    stackView.setInset(forRows: hiddenRows, inset: rowInset)
    stackView.setSeparatorInset(forRows: Array(hiddenRows.dropLast()), inset: separatorInset)
  }

  private func setUpExpandingRowView() {
    let expandingRow = ExpandingRowView()
    stackView.addRow(expandingRow)
  }

  private func setUpHorizontalRow() {
    let titleLabel = UILabel()
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    titleLabel.numberOfLines = 0
    titleLabel.text = "Use a horizontal layout"
    stackView.addRow(titleLabel)
    stackView.hideSeparator(forRow: titleLabel)
    stackView.setInset(forRow: titleLabel, inset: UIEdgeInsets(
      top: stackView.rowInset.top,
      left: stackView.rowInset.left,
      bottom: 4,
      right: stackView.rowInset.right))

    let captionLabel = UILabel()
    captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    captionLabel.textColor = .blue
    captionLabel.numberOfLines = 0
    captionLabel.text = "(Try scrolling horizontally!)"
    stackView.addRow(captionLabel)
    stackView.hideSeparator(forRow: captionLabel)
    stackView.setInset(forRow: captionLabel, inset: UIEdgeInsets(
      top: 0,
      left: stackView.rowInset.left,
      bottom: stackView.rowInset.bottom,
      right: stackView.rowInset.right))

    let horizontalStackView = AloeStackView()
    horizontalStackView.axis = .horizontal
    horizontalStackView.hidesSeparatorsByDefault = true
    horizontalStackView.showsHorizontalScrollIndicator = false

    horizontalStackView.contentInset = UIEdgeInsets(
      top: 0,
      left: stackView.rowInset.left / 2,
      bottom: 0,
      right: stackView.rowInset.right / 2)

    horizontalStackView.rowInset = UIEdgeInsets(
      top: stackView.rowInset.top,
      left: stackView.rowInset.left / 2,
      bottom: stackView.rowInset.bottom,
      right: stackView.rowInset.right / 2)

    horizontalStackView.heightAnchor.constraint(equalToConstant: 120).isActive = true

    stackView.addRow(horizontalStackView)
    stackView.setInset(forRow: horizontalStackView, inset: .zero)

    guard let image = UIImage(named: "black-cat") else { return }

    for imageNumber in 1...10 {
      let imageView = UIImageView(image: image)
      imageView.isUserInteractionEnabled = true
      imageView.contentMode = .scaleAspectFit

      let aspectRatio = image.size.height / image.size.width
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true

      horizontalStackView.addRow(imageView)

      horizontalStackView.setTapHandler(forRow: imageView) { [weak self] _ in
        let alert = UIAlertController(
          title: "Tapped on image \(imageNumber)",
          message: nil,
          preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self?.present(alert, animated: true)
      }
    }
  }

  private func setUpPhotoRow() {
    let titleLabel = UILabel()
    titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    titleLabel.numberOfLines = 0
    titleLabel.text = "Handle user interaction"
    stackView.addRow(titleLabel)
    stackView.hideSeparator(forRow: titleLabel)
    stackView.setInset(forRow: titleLabel, inset: UIEdgeInsets(
      top: stackView.rowInset.top,
      left: stackView.rowInset.left,
      bottom: 4,
      right: stackView.rowInset.right))

    let captionLabel = UILabel()
    captionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
    captionLabel.textColor = .blue
    captionLabel.numberOfLines = 0
    captionLabel.text = "(Try tapping on the photo!)"
    stackView.addRow(captionLabel)
    stackView.hideSeparator(forRow: captionLabel)
    stackView.setInset(forRow: captionLabel, inset: UIEdgeInsets(
      top: 0,
      left: stackView.rowInset.left,
      bottom: stackView.rowInset.bottom,
      right: stackView.rowInset.right))

    guard let image = UIImage(named: "black-cat") else { return }
    let aspectRatio = image.size.height / image.size.width

    let imageView = UIImageView(image: image)
    imageView.isUserInteractionEnabled = true
    imageView.contentMode = .scaleAspectFit
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true

    stackView.addRow(imageView)
    stackView.setTapHandler(forRow: imageView) { [weak self] _ in
      guard let self = self else { return }
      let vc = PhotoViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }

}
