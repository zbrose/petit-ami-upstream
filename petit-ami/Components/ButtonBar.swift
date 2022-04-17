//
//  ButtonBar.swift
//  petit-ami
//
//  Created by Triston Palacios on 4/13/22.
//

import SwiftUI
struct HungerGaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.red
    var strokeWidth = 2.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
            Image("pizza")
                .resizable()
                .padding(1.5)
                .frame(width: 50, height: 50)
        }
        
        
    }
    
}

struct EnergyGaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.yellow
    var strokeWidth = 2.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
            Image("Bolt")
                .resizable()
                .padding(1.5)
                .frame(width: 40, height: 40)
        }
        
        
    }
    
}

struct HappinessGaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.green
    var strokeWidth = 2.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
            Image("Happy")
                .resizable()
                .padding(1.5)
                .frame(width: 50, height: 50)
        }
        
        
    }
    
}

struct HygieneGaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.brown
    var strokeWidth = 2.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
            Image("Stink")
                .resizable()
                .padding(1.5)
                .frame(width: 50, height: 50)
        }
        
        
    }
    
}

struct ButtonBar: View {
    @StateObject var realmManager = RealmManager()
    @State private var showNameAmiView = false
    @State var hungerRemaining = RealmManager().amis[0].hunger
    @State var hygieneRemaining = RealmManager().amis[0].hygiene
    @State var happinessRemaining = RealmManager().amis[0].happiness
    @State var energyRemaining = Double(RealmManager().amis[0].energy)
    @State private var showInstructions = false
    @State public var sleepState: Bool = false
    @State var shownImage = "BabyCrack"
    @State var lStage = "egg"
    let timer = Timer.publish(every: 100, on: .main, in: .common).autoconnect()
    let timerThree = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let energyTimer = Timer.publish(every: 1000, on: .main, in: .common).autoconnect()
   
    func daysSince(date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }
    
    func lifeStage(int: Int) -> String{
        if (int >= 100) {
            return "adult"
        } else if (int >= 50) {
            return "teenager"
        } else if (int >= 3) {
            return "child"
        } else if (int >= 2) {
            return "baby"
        } else {
            return "egg"
        }
    }
    var body: some View {
        VStack{
            let amiAge = daysSince(date: RealmManager().amis[0].creationDate)
            let lStage = lifeStage(int: amiAge)
            Button{
                showInstructions.toggle()
                print(lStage)
            } label :{
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .sheet(isPresented: $showInstructions){
                InstructionsView()
            }
            Spacer()
            VStack{
                
                Text("\(realmManager.amis[0].name)")
                    .font(.system(size: 30, weight: .bold, design: .default))
    //            print("\(ButtonInfo)")
            HStack{
                VStack{
                    
                    Text("Age: \(amiAge) d / \(lifeStage(int: amiAge))")
                        .font(.system(size: 10, weight: .bold, design: .default))
                }
            
            }
                
            }
            HStack{
                ProgressView(value: Float(energyRemaining)/100)
                    .progressViewStyle(EnergyGaugeProgressStyle())
                    .frame(width: 50, height: 50)
                                .contentShape(Rectangle())
                    .onReceive(timer) { _ in
                        if (sleepState == true && energyRemaining + 1 < 100) {
                            energyRemaining += 1
                            realmManager.increaseAmiEnergy(id: realmManager.amis[0].id)
                        } else if (sleepState == false && energyRemaining - 0.2 > 0) {
                            energyRemaining -= 0.2
                            realmManager.decreaseAmiEnergy(id: realmManager.amis[0].id)
                        }
                    }
                    .font(.system(size: 10, weight: .bold, design: .default))
                    .onAppear()
                    .padding()
                ProgressView(value: Float(hygieneRemaining)/100)
                    .progressViewStyle(HygieneGaugeProgressStyle())
                    .frame(width: 50, height: 50)
                                .contentShape(Rectangle())
                    .onReceive(timer) { _ in
                        if hygieneRemaining > 0 {
                            hygieneRemaining -= 1
                            realmManager.decreaseAmiThirst(id: realmManager.amis[0].id)
                        }
                    }
                    .padding()
                ProgressView(value: Float(happinessRemaining)/100)
                    .progressViewStyle(HappinessGaugeProgressStyle())
                    .frame(width: 50, height: 50)
                                .contentShape(Rectangle())
                    .onReceive(timer) { _ in
                        if ((hygieneRemaining < 50 || hungerRemaining < 50) && happinessRemaining > 0) {
                            happinessRemaining -= 1
                            realmManager.decreaseAmiHappiness(id: realmManager.amis[0].id)
                        } else if ((hygieneRemaining >= 50 && hungerRemaining >= 50) && happinessRemaining < 100) {
                            happinessRemaining += 1
                            realmManager.increaseAmiHappiness(id: realmManager.amis[0].id)
                        }
                    }
                    .padding()
                ProgressView(value: Float(hungerRemaining)/100)
                    .progressViewStyle(HungerGaugeProgressStyle())
                    .frame(width: 50, height: 50)
                                .contentShape(Rectangle())
                    .onReceive(timer) { _ in
                        if hungerRemaining > 0 {
                            hungerRemaining -= 1
                            realmManager.decreaseAmiHunger(id: realmManager.amis[0].id)
                        }
                    }
                    .onAppear()
                    .padding()
                
            }
            
            if( lStage == "egg"){
                if(sleepState == true) {
                    GifImage("SleepingEgg")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                } else if shownImage == "HeartEgg"{
                    GifImage("HeartEgg")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .onReceive(timerThree) { _ in
//                            Image("Still-1")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .padding(.all)
//                              .frame(width: 375.0, height: 450.0, alignment: .top)
                            shownImage = "Still"
                            
                            }
                } else if(shownImage == "EggEating") {
                    GifImage("EggEating")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .onReceive(timerThree) { _ in
//                            Image("Still-1")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .padding(.all)
//                              .frame(width: 375.0, height: 450.0, alignment: .top)
                            shownImage = "Still"}
                }else if(hygieneRemaining < 20 ) {
                    GifImage("poopEgg")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                }else{
                    GifImage("Still")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                  
                }
            }else if(lStage == "baby"){
                if(sleepState == true) {
                    GifImage("BabySleep")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                } else if shownImage == "HeartEgg"{
                    GifImage("BabyHeart")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .onReceive(timerThree) { _ in
//                            Image("Still-1")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .padding(.all)
//                              .frame(width: 375.0, height: 450.0, alignment: .top)
                            shownImage = "BabyStill"
                            
                            }
                } else if(shownImage == "EggEating") {
                    GifImage("BabyEat")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .onReceive(timerThree) { _ in
//                            Image("Still-1")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .padding(.all)
//                              .frame(width: 375.0, height: 450.0, alignment: .top)
                            shownImage = "BabyStill"}
                }else if(hygieneRemaining < 20 ) {
                    GifImage("BabyStink")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                }else{
                    GifImage("BabyStill")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                  
                }
            }else if(lStage == "child"){
                if(sleepState == true) {
                    GifImage("TeenSleep")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                } else if shownImage == "HeartEgg"{
                    GifImage("TeenHeart")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .onReceive(timerThree) { _ in
//                            Image("Still-1")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .padding(.all)
//                              .frame(width: 375.0, height: 450.0, alignment: .top)
                            shownImage = "BabyStill"
                            
                            }
                } else if(shownImage == "EggEating") {
                    GifImage("TeenEat")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .onReceive(timerThree) { _ in
//                            Image("Still-1")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .padding(.all)
//                              .frame(width: 375.0, height: 450.0, alignment: .top)
                            shownImage = "BabyStill"}
                }else if(hygieneRemaining < 20 ) {
                    GifImage("TeenStink")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                }else{
                    GifImage("TeenMove")
                        .frame(width:500,height: 500)
                        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                  
                }
            }
               
           
           
//            GifImage(shownImage)
//                .frame(width:500,height: 500)
//                .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
//            Image("Baby")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(.all)
//                .frame(width: 375.0, height: 450.0, alignment: .top)
           
        HStack{
            

            FeedButton()
                .onTapGesture {
                    if (sleepState == true) {
                        print("Sleeping")
                    } else if (hungerRemaining + 20 < 100) {
                        hungerRemaining += 20
                        realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                        shownImage = "EggEating"
                        print(shownImage)
                    } else {
                        hungerRemaining = 100
                        realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                    }
                }
         
            SleepButton(sleepState: .constant(sleepState))
                .onTapGesture {
                    sleepState.toggle()
                    print(realmManager.amis[0].energy)
                }

            
            DrinkButton()
                .onTapGesture {
                    if (sleepState == true) {
                        print("Sleeping")
                    } else if (hygieneRemaining + 20 < 100) {
                        hygieneRemaining += 20
                        realmManager.updateAmiThirst(id:realmManager.amis[0].id)
                    } else {
                        hygieneRemaining = 100
                        realmManager.updateAmiThirst(id:realmManager.amis[0].id)
                    }
                }
            
            PetButton()
                .onTapGesture {
                    if (sleepState == true) {
                        print("Sleeping")
                    } else {
                        print("Pet")
                        shownImage = "HeartEgg"
                        print(shownImage)
                        realmManager.increaseAmiHappinessManual(id:realmManager.amis[0].id)
                        happinessRemaining += 1
                    }
                }
            
                }
                .environmentObject(realmManager)
            
//            Text("\(Showhunger)")
        }
        }
        }
        
    
    



struct ButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBar()
            .environmentObject(RealmManager())
    }
}


