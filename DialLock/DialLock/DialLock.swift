//
//  DialLock.swift
//  DialLock
//
//  Created by Mac Pro on 2017. 11. 20..
//  Copyright © 2017년 Eric.Park. All rights reserved.
//

import UIKit

/**
 * Return vector from lhs point to rhs point.
 */
func - (lhs: CGPoint, rhs: CGPoint) -> CGVector {
    return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
}

// Max angle = 2 * pi
public class DialLock: UIControl {
    private let indicatorLayer = CAShapeLayer()
    private let lineWidth = CGFloat(1)
    private var lastVector = CGVector.zero
    private var angle = 0.0
    
    /**
     * Contains the current value.
     */
    public var maxValue: Int = 10
    public var value: Int {
        return Int(valueFromAngle)
    }
    
    private var valueFromAngle: Double {
        let oneTickAngle = .pi * 2 / Double(maxValue + 1)
        let value = angle / oneTickAngle
        return value
    }
    
    override public var frame: CGRect {
        didSet {
            CATransaction.doWithNoAnimation {
                self.updateLayer()
            }
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            CATransaction.doWithNoAnimation {
                self.updateLayer()
            }
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            CATransaction.doWithNoAnimation {
                self.updateLayer()
            }
        }
    }
    
    private var dialLockBackgroundColor: UIColor?
    override public var backgroundColor: UIColor? {
        get {
            return dialLockBackgroundColor
        }
        
        set {
            dialLockBackgroundColor = newValue
            updateLayer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateLayer()
    }
    
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        updateLayer()
    }
    
    private func updateLayer() {
        let shapeLayer = CAShapeLayer(layer: layer)
        
        if let color = dialLockBackgroundColor {
            shapeLayer.fillColor = isEnabled ? color.cgColor : (color.disabledColor().cgColor)
        }
        else {
            shapeLayer.fillColor = UIColor.clear.cgColor
        }
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = isEnabled ? tintColor.cgColor : (tintColor.disabledColor().cgColor)
        shapeLayer.lineWidth = lineWidth

        // Adjust drawing rectangle for line width
        var dx = shapeLayer.lineWidth / 2, dy = shapeLayer.lineWidth / 2

        // Draw perfect circle even if view is rectangular
        if bounds.width > bounds.height {
            dx += (bounds.width - bounds.height) / 2
        }
        else if bounds.height > bounds.width {
            dy += (bounds.height - bounds.width) / 2
        }
        let ovalRect = bounds.insetBy(dx: dx, dy: dy)
        shapeLayer.path = UIBezierPath(ovalIn: ovalRect).cgPath
        
        // Adjust for line width to keep tick mark inside circle
        let shortSide = min(bounds.width, bounds.height)
        indicatorLayer.bounds = CGRect(x: 0, y: 0, width: shortSide - 2 * lineWidth, height: shortSide - 2 * lineWidth)
        
        updateIndicator()
        
        indicatorLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        indicatorLayer.lineWidth = shapeLayer.lineWidth
        indicatorLayer.strokeColor = shapeLayer.strokeColor
        indicatorLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.addSublayer(indicatorLayer)
        layer.addSublayer(shapeLayer)
    }
    
    /**
     * Draw value indicator, usually in response to the value changing.
     */
    private func updateIndicator() {
        let linePath = UIBezierPath()
        
        // Adjust the angle to be in the counterclockwise direction from the positive
        // x-axis to accomodate the standard parametric equations for a circle used below.
        let t = 5 / 2 * .pi - angle
        let center = indicatorLayer.bounds.center
        
        let x1 = center.x + (indicatorLayer.bounds.width / 2) * CGFloat(cos(t))
        let y1 = center.y - (indicatorLayer.bounds.height / 2) * CGFloat(sin(t))
        linePath.move(to: CGPoint(x:x1, y:y1))
        
        let x2 = center.x + (indicatorLayer.bounds.width / 3) * CGFloat(cos(t))
        let y2 = center.y - (indicatorLayer.bounds.height / 3) * CGFloat(sin(t))
        linePath.addLine(to: CGPoint(x:x2, y:y2))
        
        indicatorLayer.path = linePath.cgPath
    }
    
    override public func beginTracking(_ touch: UITouch, with  event: UIEvent?) -> Bool {
        lastVector = touch.location(in: self) - bounds.center
        return true
    }
    
    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // Calculate vector from center to touch.
        let vector = touch.location(in: self) - bounds.center
        
        let lastValue = value
        
        // Add angular difference to our current value.
        angle = (angle + vector.angleFromVector(vector: lastVector)).truncatingRemainder(dividingBy: 2 * .pi)
        
        lastVector = vector
        
        // one Tick
        if lastValue != value{
            updateIndicator()
            sendActions(for: UIControlEvents.valueChanged)
        }
        
        return true
    }
}

