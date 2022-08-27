//
//  TimerView.swift
//  ExTimerView
//
//  Created by 김종권 on 2022/08/27.
//

import UIKit

final class TimerView: UIView {
  private enum Const {
    static let lineWidth = 10.0
    static let startAngle = CGFloat(-Double.pi / 2)
    static let endAngle = CGFloat(3 * Double.pi / 2)
    static let backgroundStrokeColor = UIColor.green.cgColor
    static let progressStrokeColor = UIColor.gray.cgColor
  }
  
  private let backgroundLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.lineWidth = Const.lineWidth
    layer.strokeEnd = 1
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = Const.backgroundStrokeColor
    return layer
  }()
  private let progressLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.lineWidth = Const.lineWidth
    layer.strokeEnd = 0
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = Const.progressStrokeColor
    return layer
  }()
  private var circularPath: UIBezierPath { // 런타임 시에 동적으로 결정되는 frame값을 알기 위해 computed property로 선언
    UIBezierPath(
      arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2),
      radius: self.frame.size.width / 2,
      startAngle: Const.startAngle,
      endAngle: Const.endAngle,
      clockwise: true
    )
  }
  
  var backgroundLayerColor: CGColor? {
    get { self.backgroundLayer.strokeColor }
    set { self.backgroundLayer.strokeColor = newValue }
  }
  var progressLayerColor: CGColor? {
    get { self.progressLayer.strokeColor }
    set { self.progressLayer.strokeColor = newValue }
  }
  var lineWidth: CGFloat {
    get { self.backgroundLayer.lineWidth }
    set { self.backgroundLayer.lineWidth = newValue }
  }
  
  required init() {
    super.init(frame: .zero)
    
    self.backgroundColor = .clear
    self.backgroundLayer.path = self.circularPath.cgPath
    self.progressLayer.path = self.circularPath.cgPath
    
    self.layer.addSublayer(self.backgroundLayer)
    self.layer.addSublayer(self.progressLayer)
  }
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    self.backgroundLayer.path = self.circularPath.cgPath
    self.progressLayer.path = self.circularPath.cgPath
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func start(duration: TimeInterval) {
    self.progressLayer.removeAnimation(forKey: "progress")
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    circularProgressAnimation.duration = duration
    circularProgressAnimation.toValue = 1.0
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    self.progressLayer.add(circularProgressAnimation, forKey: "progress")
  }
}
