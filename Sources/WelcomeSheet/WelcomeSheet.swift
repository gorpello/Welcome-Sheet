//
//  WelcomeSheet.swift
//
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI
 
struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    
    let pages: [WelcomeSheetPage]
    let onDismiss: () -> Void
    let isSlideToDismissDisabled: Bool
    let preferredColorScheme: ColorScheme?

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet) {
                WelcomeSheetView(pages: pages, onDismiss: getOnDismiss())
                    .interactiveDismissDisabled(isSlideToDismissDisabled)
            }            
    }
    
    func getOnDismiss() -> () -> Void {
        return {
            showSheet = false
            onDismiss()
        }
    }
}

public extension View {
    /// Presents Welcome Sheet with given pages when a binding to a Boolean value that you provide is true.
    func welcomeSheet(
        isPresented showSheet: Binding<Bool>,
        isSlideToDismissDisabled: Bool = false,
        preferredColorScheme: ColorScheme? = nil,
        pages: [WelcomeSheetPage],
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, preferredColorScheme: preferredColorScheme))
    }
}
