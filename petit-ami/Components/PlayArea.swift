//
//  PlayArea.swift
//  petit-ami
//
//  Created by Triston Palacios on 4/13/22.
//

import SwiftUI

struct PlayArea: View {
    var body: some View {
        Image("Still-1")
            .resizable()
            .frame(width: 350.0, height: 250.0, alignment: .top)
        
      
    }
}

struct PlayArea_Previews: PreviewProvider {
    static var previews: some View {
        PlayArea()
    }
}
