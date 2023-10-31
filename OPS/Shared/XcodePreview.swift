//
//  XcodePreview.swift
//  Whoops
//
//  Created by Aaron on 4/26/21.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ViewControllerPreview: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    let viewControllerBuilder: () -> UIViewControllerType

    init(_ viewControllerBuilder: @escaping () -> UIViewControllerType) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        viewControllerBuilder()
    }
    @available(iOS 13.0.0, *)
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Not needed
    }
}

struct ViewPreview: UIViewRepresentable {
    
    let viewBuilder: () -> UIViewType

    init(_ viewBuilder: @escaping () -> UIViewType) {
        self.viewBuilder = viewBuilder
    }
    
    func makeUIView(context: Context) -> UIView {
        viewBuilder()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
    
}
#endif
