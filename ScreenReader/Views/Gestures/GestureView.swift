//
//  GestureView.swift
//  Appt
//
//  Created by Jan Jaap de Groot on 24/06/2020.
//  Copyright © 2020 Stichting Appt All rights reserved.
//

import UIKit

protocol GestureViewDelegate {
    func correct(_ gesture: Gesture)
    func incorrect(_ gesture: Gesture, feedback: String)
}

class GestureView: UIView {
    
    private var observer: NSKeyValueObservation?
    
    var delegate: GestureViewDelegate?
    var gesture: Gesture!
    var completed = false
    
    convenience init(gesture: Gesture) {
        self.init()
        self.gesture = gesture
        
        isAccessibilityElement = true
        isMultipleTouchEnabled = true
        accessibilityTraits = .allowsDirectInteraction
        accessibilityLabel = String(format: "%@: %@", gesture.title, gesture.description)
        
        isOpaque = false
        clearsContextBeforeDrawing = false
        backgroundColor = .clear
        
        observer = layer.observe(\.bounds) { object, _ in
            self.map.removeAll()
            self.setNeedsDisplay()
        }
    }
    
    deinit {
        observer?.invalidate()
    }
    
    func correct(_ recognizer: UIGestureRecognizer? = nil) {
        if !completed {
            completed = true
            
            setNeedsDisplay()
            
            delay(0.1) {
                self.delegate?.correct(self.gesture)
            }
        }
    }
    
    func incorrect(_ feedback: String) {
        if !completed {
            delegate?.incorrect(gesture, feedback: feedback)
        }
    }
    
    override func accessibilityPerformEscape() -> Bool {
        // This gesture is ignored to avoid unwanted behaviour.
        return true
    }
    
    override func accessibilityPerformMagicTap() -> Bool {
        // This gesture is ignored to avoid unwanted behaviour.
        return true
    }
    
    var map: [String: [Point]] = [String: [Point]]()

    struct Point {
        var location: CGPoint
        var tapCount: Int
        var longPress: Bool = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //print("touchesBegan")
        map.removeAll()
        onTouches(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        //print("touchesMoved")
        onTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        //print("touchesEnded")
        onTouches(touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        //print("touchesCancelled")
    }
    
    private func onTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            let fingerprint = String(format: "%p", touch)
            let location = touch.location(in: self)
            
            let point = Point(location: location, tapCount: touch.tapCount)
            
            if var points = map[fingerprint], let lastPoint = points.last, lastPoint.location != point.location {
                points.append(point)
                map[fingerprint] = points
            } else {
                map[fingerprint] = [point]
            }
        }
        
        setNeedsDisplay()
    }

    func showTouches(recognizer: UIGestureRecognizer, tapCount: Int = 1, longPress: Bool = false) {
        guard recognizer.numberOfTouches > 0 else {
            return
        }
        
        map.removeAll()
        
        for i in 0...recognizer.numberOfTouches-1 {
            let fingerprint = String(i)
            let location = recognizer.location(ofTouch: i, in: self)
            
            let point = Point(location: location, tapCount: tapCount, longPress: longPress)
            
            map[fingerprint] = [point]
        }
        
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        let color = UIColor.primary.cgColor
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color)
        context?.setFillColor(color)
        context?.setLineCap(.round)
        
        for key in map.keys {
            guard let points = map[key],
                  let firstPoint = points.first else {
                continue
            }
            
            context?.beginPath()
            
            drawCircles(firstPoint, context: context)
            
            if points.count > 1 {
                context?.move(to: firstPoint.location)
                
                for point in points {
                    drawLine(point, context: context)
                }
                
                drawArrow(points, context: context)
            }
            
            context?.strokePath()
        }
    }
    
    private func drawLine(_ point: Point, context: CGContext?, thickness: CGFloat = 15.0) {
        context?.setLineWidth(thickness)
        context?.addLine(to: point.location)
    }
    
    private func drawCircles(_ point: Point, context: CGContext?, thickness: CGFloat = 10.0, size: CGFloat = 50.0) {
        context?.setLineWidth(thickness)
        
        if point.tapCount > 0 {
            context?.move(to: point.location)
            
            for i in 0...point.tapCount-1 {
                let size = size + CGFloat(i) * size
                
                let circle = CGRect(x: point.location.x - size/2, y: point.location.y - size/2, width: size, height: size)
                context?.strokeEllipse(in: circle)
                
                if point.longPress, i == 0 {
                    context?.fillEllipse(in: circle)
                }
            }
        }
    }
    
    private func drawArrow(_ points: [Point], context: CGContext?, thickness: CGFloat = 15.0, size: CGFloat = 50.0) {
        let subset = points.suffix(5)
        guard subset.count >= 2,
              let start = subset.first?.location,
              let end = subset.last?.location else {
            return
        }

        let angle = CGFloat(Double.pi / 4)
    
        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let top = CGPoint(x: end.x + size * cos(CGFloat(Double.pi) - startEndAngle + angle), y: end.y - size * sin(CGFloat(Double.pi) - startEndAngle + angle))
        let bottom = CGPoint(x: end.x + size * cos(CGFloat(Double.pi) - startEndAngle - angle), y: end.y - size * sin(CGFloat(Double.pi) - startEndAngle - angle))

        context?.setLineWidth(thickness)
        
        context?.move(to: end)
        context?.addLine(to: top)
        
        context?.move(to: end)
        context?.addLine(to: bottom)
    }
}
