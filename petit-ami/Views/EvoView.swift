//
//  EvoView.swift
//  petit-ami
//
//  Created by Zach Brose on 4/16/22.
//

import SwiftUI

struct EvoView: View {
    var body: some View {
        VStack {
            Text("Your Ami is Evolving!")
                .font(.title).bold()
                .padding()

            
            GifImage("BabyCrack")
                .frame(width:400,height: 400)
                
        }
        .padding()
    }
    
}

struct EvoView_Previews: PreviewProvider {
    static var previews: some View {
        EvoView()
    }
}
