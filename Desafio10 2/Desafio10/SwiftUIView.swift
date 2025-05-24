//
//  SwiftUIView.swift
//  Desafio10
//
//  Created by Turma02-28 on 30/04/25.
//

import SwiftUI

struct SwiftUIView: View {
    
    var recebe : HaPo
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black ,.red, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: recebe.image!)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                } placeholder: {
                    ProgressView()
                }
                VStack{
                    Text(recebe.name!)
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(recebe.patronus!)
                        .foregroundStyle(.white)
                        .padding()
                    
                    Spacer()
                }
            }//.foregroundStyle(.white)
        }
    }

    }


#Preview {
    SwiftUIView(recebe: HaPo(
        id: "1",
        name: "Harry Potter",
        alternate_names: [],
        species: "Human",
        gender: "Male",
        house: "Gryffindor",
        dateOfBirth: "31-07-1980",
        yearOfBirth: 1980,
        wizard: true,
        ancestry: "Half-blood",
        eyeColour: "Green",
        hairColour: "Black",
        wand: Wand(wood: "Holly", core: "Phoenix feather", length: 11),
        patronus: "Stag",
        hogwartsStudent: true,
        hogwartsStaff: false,
        actor: "Daniel Radcliffe",
        alternate_actors: [],
        alive: true,
        image: "https://hp-api.onrender.com/images/harry.jpg"
    ))
}
