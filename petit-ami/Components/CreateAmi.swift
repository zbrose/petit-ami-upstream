//
//  CreateAmi.swift
//  petit-ami
//
//  Created by Bryan Nguyen on 4/13/22.
//

import SwiftUI

struct CreateAmi: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50)
                .foregroundColor(Color(hue: 0.000, saturation: 0.000, brightness: 0.908))
            
            Text("+")
                .font(.system(size: 30.0, weight: .bold))
        }
        .frame(height:50)
    }
}

struct CreateAmi_Previews: PreviewProvider {
    static var previews: some View {
        CreateAmi()
    }
}
