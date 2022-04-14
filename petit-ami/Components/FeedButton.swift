//
//  FeedButton.swift
//  petit-ami
//
//  Created by Zach Brose on 4/12/22.
//

import SwiftUI

struct FeedButton: View {
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50)
                .foregroundColor(Color(hue: 0.000, saturation: 0.000, brightness: 0.908))
            
            Image("pizza")
                .resizable()
                .padding(.all)
                .padding(.top,5)
                .frame(width: 80, height: 80)
        }
        .frame(height:50)
    }
}

struct FeedButton_Previews: PreviewProvider {
    static var previews: some View {
        FeedButton()
    }
}
