//
//  ResetButton.swift
//  petit-ami
//
//  Created by Bryan Nguyen on 4/17/22.
//

import SwiftUI

struct ResetButton: View {
    @State var showNameAmiView = false
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20) // Our button
                .fill(Color(.red))
                            .frame(width: 150, height: 50)
                            .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(.black), lineWidth: 7)
                                    .frame(width: 300 , height: 70)
                                    .offset(x: 0, y: -5)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 100, height: 50)
                                    )
                            )
            

            
            Text("Start Over")
                .foregroundColor(.white)
                .font(.title)
        }
        .frame(height:50)
    }
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton()
    }
}
