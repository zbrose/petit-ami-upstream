//
//  ReplaceAmiView.swift
//  petit-ami
//
//  Created by Bryan Nguyen on 4/17/22.
//

import SwiftUI

struct ReplaceAmiView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var name: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Welcome to Petit Ami!")
                .font(.title).bold()
                .padding()
            Text("What do you want to name your Ami?")
                .font(.title2).bold()
                .frame(maxWidth: 300)
            
            TextField(
                "Enter name here",
                text: $name
            )
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 200)
            
            Button{
                if name != "" {
                    realmManager.replaceAmi(id:realmManager.amis[0].id, amiName: name)
                }
                dismiss()
            } label: {
                Text("Next")
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(30)
            }
        }
    }
}

struct ReplaceAmiView_Previews: PreviewProvider {
    static var previews: some View {
        ReplaceAmiView()
    }
}
