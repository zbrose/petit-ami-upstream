import SwiftUI

struct FeedButton: View {
    
    var body: some View {
        ZStack {
            
            Circle() // Our button
                .fill(Color(.gray))
                            .frame(width: 50, height: 50)
                            .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 8)
                            .overlay(
                                Circle()
                                    .stroke(Color(.black), lineWidth: 7)
                                    .frame(width: 60, height: 60)
                                    .offset(x: 0, y: -5)
                                    .mask(
                                        Circle()
                                            .frame(width: 50, height: 50)
                                    )
                            )
            

            
            Image("PizzaW")
                .resizable()
                .padding()
                .frame(width: 70, height: 70)
                

                
        }
        .frame(height:50)
    }
}

struct FeedButton_Previews: PreviewProvider {
    static var previews: some View {
        FeedButton()
    }
}
