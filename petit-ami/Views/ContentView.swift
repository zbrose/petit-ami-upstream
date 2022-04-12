//
//  ContentView.swift
//  petit-ami
//
//  Created by Zach Brose on 4/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            FeedButton()
                .padding()
            
            SleepButton()
                .padding()
            
            DrinkButton()
                .padding()
            
            PetButton()
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



