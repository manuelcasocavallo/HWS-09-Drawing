//
//  ContentView.swift
//  HWS-09-Drawing
//
//  Created by Manuel Casocavallo on 02/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Triangle()
                .stroke(LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.pink]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 15, lineJoin: .miter))
                .frame(width: 100, height: 100)
                .padding()
            
            ZStack {
                Arc(startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)
                    .strokeBorder(Color.blue, lineWidth: 20)
                    .frame(width: 150, height: 150)
                Arc(startAngle: .degrees(90), endAngle: .degrees(180), clockwise: true)
                    .stroke(Color.green, lineWidth: 20)
                    .frame(width: 150, height: 150)
                Arc(startAngle: .degrees(180), endAngle: .degrees(270), clockwise: true)
                    .strokeBorder(Color.yellow, lineWidth: 20)
                    .frame(width: 150, height: 150)
                Arc(startAngle: .degrees(270), endAngle: .degrees(0), clockwise: true)
                    .stroke(Color.red, lineWidth: 20)
                    .frame(width: 150, height: 150)
            }
            .padding()
            
            HStack(spacing: 40) {
                Circle()
                    .strokeBorder(Color.red, lineWidth: 20)
                    .frame(width: 100, height: 100)
                    .background(Color.black)
                Circle()
                    .stroke(Color.red, lineWidth: 20)
                    .frame(width: 100, height: 100)
                    .background(Color.black)
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2 - insetAmount,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: !clockwise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
