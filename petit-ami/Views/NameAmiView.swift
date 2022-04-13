//
//  NameAmiView.swift
//  petit-ami
//
//  Created by Bryan Nguyen on 4/12/22.
//

import SwiftUI

struct NameAmiView: View {
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
                    realmManager.addAmi(amiName: name)
                    
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

struct NameAmiView_Previews: PreviewProvider {
    static var previews: some View {
        NameAmiView()
    }
}
