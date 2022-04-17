//
//  EvoButton.swift
//  petit-ami
//
//  Created by Zach Brose on 4/16/22.
//

import SwiftUI

struct EvoButton: View {
    
    var body: some View {
        ZStack {
            Rectangle() // Our button
                .fill(Color(.green))
                .frame(width: 70, height: 50)
                .cornerRadius(75)
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 8)
//                .overlay(
//                    Rectangle()
//                        .stroke(Color(.black), lineWidth: 5)
//                        .frame(width: 80, height: 60)
//                        .offset(x: 0, y: -7)
//                        .mask(
//                            Rectangle()
//                                .frame(width: 67.0, height: 50)
//                                .cornerRadius(100)
//                        )
//                )
            Text("Evolve!")
                .padding()
                }

    }
}

struct EvoButton_Previews: PreviewProvider {
    static var previews: some View {
        EvoButton()
    }
}
