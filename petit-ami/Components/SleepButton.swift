//
//  SleepButton.swift
//  petit-ami
//
//  Created by Zach Brose on 4/12/22.
//

import SwiftUI

struct SleepButton: View {
    @Binding var sleepState: Bool

    var body: some View {

        ZStack {
            Circle()
                .frame(width: 50)
                .foregroundColor(sleepState == false ? Color(hue: 0.000, saturation: 0.000, brightness: 0.908) : Color(hue: 0.900, saturation: 0.900, brightness: 0.108))
            
            Circle() // Our button
                .fill(Color(.gray))
                            .frame(width: 50, height: 50)
                            .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 8)
                            .overlay(
                                Circle()
                                    .stroke(Color(.black), lineWidth: 7)
                                    .frame(width: 60, height: 60)
                                    .offset(x: 0, y: -5)
                                    .mask(
                                        Circle()
                                            .frame(width: 50, height: 50)
                                    )
                            )
            

            
            Image("SleepW")
                .resizable()
                .padding()
                .frame(width: 70, height: 70)
                

                
        }
        .frame(height:50)
    }
}

struct SleepButton_Previews: PreviewProvider {
    static var previews: some View {
        SleepButton(sleepState: .constant(false))
            
    }
}
