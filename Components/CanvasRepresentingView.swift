//
//  CanvasRepresentingView.swift
//  
//
//  Created by 정종인 on 2/19/24.
//

import SwiftUI
import PencilKit

struct CanvasRepresentingView: UIViewRepresentable {
    var canvasView: PKCanvasView
    let picker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        self.canvasView.becomeFirstResponder()
        return canvasView
    }


    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        picker.addObserver(canvasView)
        picker.setVisible(true, forFirstResponder: uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }
}

#Preview {
    CanvasRepresentingView(canvasView: PKCanvasView())
}
