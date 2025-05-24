//
//  ContentView.swift
//  Desafio10
//
//  Created by Turma02-28 on 24/04/25.
//

import SwiftUI

struct ContentView: View {
//    init() {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor.white
//            UITabBar.appearance().standardAppearance = appearance
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
    
    var body: some View {        
        TabView {
            MapView()
                .tabItem {
                    Label("Início", systemImage: "map")
                }
            EventosView()
                .tabItem {
                    Label("Eventos", systemImage: "ticket")
                }
            SaveView()
                .tabItem {
                    Label("Eventos Salvos", systemImage: "bookmark")
                }
        }.tint(.white)
    }
}

#Preview {
    ContentView()
}
