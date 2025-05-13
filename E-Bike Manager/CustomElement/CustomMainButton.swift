//
//  CustomMainButton.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct CustomMainButton: View {
    var action: () -> Void // Dies ist ein Closure, das nichts annimmt und nichts zurückgibt (Void). Es ist die Aktion, die bei einem Klick auf den Button ausgeführt wird.

    var title: String
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline.bold())
                .frame( height: 50)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 3))
        }
        .shadow(radius: 3)
        
    }
}


