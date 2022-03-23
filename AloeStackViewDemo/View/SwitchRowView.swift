//
//  SwitchRowView.swift
//  AloeStackViewDemo
//
//  Created by Sergey Lukaschuk on 23.03.2022.
//

import AloeStackView
import UIKit

public class SwitchRowView: UIView {

  // MARK: Lifecycle
  public init() {
    super.init(frame: .zero)
    setUpViews()
    setUpConstraints()
  }

  public required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Public
  public var text: String? {
    get { return label.text }
    set { label.text = newValue}
  }

  public var switchDidChange: ((_ isOn: Bool) -> Void)?

  // MARK: Private
  private let label = UILabel()
  private let switchView = UISwitch(frame: .zero)

  private func setUpViews() {
    setUpLabel()
    setUpSwitchView()
  }

  private func setUpLabel() {
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    addSubview(label)
  }

  private func setUpSwitchView() {
    switchView.translatesAutoresizingMaskIntoConstraints = false
    switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    addSubview(switchView)
  }

  @objc private func switchChanged() {
    switchDidChange?(switchView.isOn)
  }

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      switchView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
      switchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
      switchView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -1)
    ])
  }

}

extension SwitchRowView: Tappable {

  public func didTapView() {
    switchView.setOn(!switchView.isOn, animated: true)
    switchView.sendActions(for: .valueChanged)
  }

}

