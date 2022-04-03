//
//  TestViewController.swift
//  AloeStackViewDemo
//
//  Created by Sergey Lukaschuk on 03.04.2022.
//

import UIKit
import AloeStackView

class TestViewController: AloeStackViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSelf()
        setUpRows()
    }

    private func setUpSelf() {
        title = "Test"
    }

    private func setUpStackView() {
        stackView.hidesSeparatorsByDefault = false
    }

    private func setUpRows() {
        setUpLabel()
    }

    private func setUpLabel() {
        for i in 1...50 {
            let label = UILabel()
            label.text = "Label \(i)"
            label.isUserInteractionEnabled = true
            stackView.addRow(label)

            stackView.setTapHandler(forRow: label) { [weak self] _ in
              let alert = UIAlertController(
                title: "Tapped on Label \(i)",
                message: nil,
                preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
              self?.present(alert, animated: true)
            }
        }
    }
}
