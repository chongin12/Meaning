//
//  CanvasRepresentingView.swift
//  
//
//  Created by 정종인 on 2/19/24.
//

import SwiftUI
import PencilKit

struct CanvasRepresentingView: UIViewRepresentable {

    class Coordinator: NSObject {
        let canvasView: PKCanvasView
        let toolPicker: PKToolPicker

        deinit {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
            toolPicker.removeObserver(canvasView)
        }

        init(canvasView: PKCanvasView, toolPicker: PKToolPicker) {
            self.canvasView = canvasView
            self.toolPicker = toolPicker
        }
    }

    var canvasView: PKCanvasView
    let picker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        context.coordinator.canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        picker.addObserver(context.coordinator.canvasView)
        context.coordinator.canvasView.becomeFirstResponder()
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        context.coordinator.toolPicker.setVisible(true, forFirstResponder: uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: canvasView, toolPicker: picker)
    }
}

#Preview {
    CanvasRepresentingView(canvasView: PKCanvasView())
}
