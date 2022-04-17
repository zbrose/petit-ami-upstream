//
//  ContentView.swift
//  petit-ami
//
//  Created by Zach Brose on 4/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    @State private var showNameAmiView = false
//    @State private var showInstructions = false
    @State private var showEvolutionView = false
   
    var body: some View {
    
        
        (realmManager.amis.count > 0 ? AnyView(ButtonBar()) : AnyView(NameAmiView().environmentObject(realmManager)))
//            List {
//                ForEach(realmManager.amis, id: \.id) { ami in
//                    if !ami.isInvalidated {
//                        Text(String(ami.hunger-25))
//                    }
//                }
//            }
//
            
//            CreateAmi()
//                .onTapGesture{
//                    showNameAmiView.toggle()
//                    
//                }
    
        
        .sheet(isPresented: $showNameAmiView) {
            NameAmiView()
                .environmentObject(realmManager)
//        .sheet(isPresented: $showInstructions){
//            InstructionsView()
//        }
        .sheet(isPresented: $showEvolutionView){
            EvoView()
        }
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RealmManager())
    }
}



