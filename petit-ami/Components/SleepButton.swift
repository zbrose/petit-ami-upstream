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
            
            Image("Sleep")
                .resizable()
                .padding(.all)
                .padding(.top,5)
                .frame(width: 80, height: 80)
        }
        .frame(height:50)
    }
}

struct SleepButton_Previews: PreviewProvider {
    static var previews: some View {
        SleepButton(sleepState: .constant(false))
            
    }
}
