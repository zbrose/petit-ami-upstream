//
//  InstructionsVie.swift
//  petit-ami
//
//  Created by Zach Brose on 4/14/22.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack {
            Text("Welcome to Petit Ami!")
                .font(.title).bold()
                .padding()
            Text("Congratulations on adopting your Ami! Over time, your Ami's status will change.  You can keep your Ami happy and growing by taking good care of it using the actions below.  You wouldn't want it to starve now, would you?")
                .multilineTextAlignment(.center)
                .padding()

            HStack{
                Text("Press")
                FeedButton()
                Text("to feed your Ami.")
            }
            
            HStack{
                Text("Press")
                PetButton()
                Text(" to pet your Ami.")
            }
            HStack{
                Text("Press")
                DrinkButton()
                Text("to hydrate your Ami.")
            }
            HStack{
                Text("Press")
                SleepButton(sleepState: .constant(false))
                Text("to put your Ami to sleep.")
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
