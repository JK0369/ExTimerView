//
//  ViewController.swift
//  ExTimerView
//
//  Created by 김종권 on 2022/08/27.
//

import UIKit

class ViewController: UIViewController {
  let imageView = RoundImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.imageView.image = UIImage(named: "dog")
    self.view.addSubview(self.imageView)
    self.imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.imageView.heightAnchor.constraint(equalToConstant: 300),
      self.imageView.widthAnchor.constraint(equalToConstant: 300),
      self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.addTimerView(on: self.imageView)
  }
  
  private func addTimerView(on subview: UIView) {
    let timerView = TimerView()
    subview.addSubview(timerView)
    timerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      timerView.leftAnchor.constraint(equalTo: subview.leftAnchor),
      timerView.rightAnchor.constraint(equalTo: subview.rightAnchor),
      timerView.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
      timerView.topAnchor.constraint(equalTo: subview.topAnchor),
    ])
    timerView.start(duration: 20)
  }
}

final class RoundImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.clipsToBounds = true
    self.layer.cornerRadius = self.bounds.height / 2.0
  }
}
