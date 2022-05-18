//
//  CloseModifier.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/3/21.
//

import SwiftUI

struct CloseModifier: ViewModifier {

    @Environment(\.presentationMode) var presentationMode
    //makes it dynamic
    func body(content: Content) -> some View{
        content
            .toolbar{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
    }
}

extension View{
    //here is our function to call
    func applyClose() -> some View{
        self.modifier(CloseModifier())
    }
}
