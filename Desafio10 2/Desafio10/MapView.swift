import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var offsetY: CGFloat = 450 // Posição inicial da sheet
    
    @State private var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -15.790669, longitude: -47.892967),
            span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
    )
    
    @State private var searchText = ""
    @State private var showFilters = false
    
    @StateObject private var viewModel = ViewModel()
    
    @State var categories: [String] = ["Restaurante", "Cultura", "Esportes", "Festa"]
    @State var categoriaAux: String = "Todos"
    
    @State private var activeCategories: Set<String> = []
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                Map(position: $region){
                    ForEach(viewModel.local, id: \.self) { lugar in
                            if categoriaAux == "Todos" || lugar.categoria == categoriaAux {
                                Annotation("teste", coordinate: CLLocationCoordinate2D(
                                    latitude: lugar.localizacao.latitude,
                                    longitude: lugar.localizacao.longitude)) {
                                NavigationLink(destination: EventView(place: lugar)){
                                    VStack(spacing: 4) {
                                        Image(systemName: iconForCategory(lugar.categoria))
                                            .font(.title)
                                            .foregroundColor(colorForCategory(lugar.categoria)).shadow(radius: 5)
                                        Text(lugar.nome)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .cornerRadius(6)
                                            .shadow(radius: 5)
                                    }
                                }
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        showFilters = false
                    }
                }
                
                SheetView()
                    .offset(y: offsetY)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newOffset = offsetY + value.translation.height
                                offsetY = max(100, min(500, newOffset))
                            }
                    )
                    .animation(.easeInOut, value: offsetY)
                    .onTapGesture {
                        withAnimation {
                            showFilters = false
                        }
                    }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    
                    TextField("", text: $searchText)
                        .foregroundColor(.white) // texto digitado branco
                        .placeholder(when: searchText.isEmpty) {
                            Text("Pesquisar")
                                .foregroundColor(.white) // Placeholder branco também
                        }
                }
                .padding(.leading, 10)
                .frame(width: 370, height: 40)
                .background(Color(.corPersonalizada))
                .cornerRadius(15)
                
                
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                showFilters.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                Text("Filtrar")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.corPersonalizada))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading, 5)
                    .padding(.top, 45)
                    
                    
                    if showFilters {
                        HStack{
                            VStack(alignment: .leading) {
                                HStack{
                                    Image(systemName: "square.grid.2x2")
                                    Text("Todos")
                                        .foregroundColor(categoriaAux == "Todos" ? .green : .white)
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            categoriaAux = "Todos"
                                        }
                                }
                                ForEach(categories, id: \.self) { c in
                                    HStack{
                                        Image(systemName: iconForCategory(c))
                                            .foregroundColor(colorForCategory(c))
                                        Text(c)
                                            .padding(3)
                                            .foregroundColor(categoriaAux == c ? .green : .white)
                                            .cornerRadius(8)
                                            .onTapGesture {
                                                categoriaAux = c
                                            }
                                    }
                                }
                            }
                            .padding(10)
                            .background(.corPersonalizada)
                            .cornerRadius(12)
                            .frame(maxWidth: 170, maxHeight: 90)
                            Spacer()
                            
                        }.padding(.leading, -5)
                        .padding(.top, 35)
                    }
                }
            }.preferredColorScheme(.dark)
                .onAppear {
                    viewModel.fetch()
                }
        }.tint(.white)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

private func filterItem(_ text: String) -> some View {
    Text(text)
        .foregroundColor(.white)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.corPersonalizada).opacity(0.6))
        .cornerRadius(8)
}


struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

func iconForCategory(_ categoria: String) -> String {
    switch categoria {
    case "Restaurante": return "fork.knife.circle.fill"
    case "Festa": return "music.mic.circle.fill"
    case "Esportes": return "figure.run.circle.fill"
    case "Cultura": return "theatermasks.circle.fill"
    default: return "mappin.circle.fill"
    }
}

func colorForCategory(_ categoria: String) -> Color {
    switch categoria {
    case "Restaurante": return .orange
    case "Festa": return .pink
    case "Esportes": return .green
    case "Cultura": return .blue
    default: return .red
    }
}

func colorForTag(tag: String) -> Color {
switch tag {
case "Francesa": return .pink
case "Gastronomia": return .orange
case "Romântico": return .red
case "Reggae": return .green
case "Festa": return .purple
case "Ao": return .gray
case "Ar": return .gray
case "Livre": return .gray
case "Teatro": return .indigo
case "Rua": return .brown
case "Cultura": return .blue
case "Futebol": return .mint
case "Esporte": return .teal
case "Competição": return .cyan
case "Vegano": return .green
case "Orgânico": return .green
case "Restaurante": return .orange
case "Comida": return .orange
case "Brasileira": return .yellow
case "Culinária": return .orange
case "Dança": return .pink
case "Eletrônica": return .purple
case "Balada": return .pink
case "DJ": return .blue
case "Forró": return .orange
case "MPB": return .brown
case "Fotografia": return .gray
case "Cerrado": return .green
case "Exposição": return .blue
case "Funk": return .red
case "Sushi": return .cyan
case "Japonês": return .blue
case "Corrida": return .red
case "Meia": return .gray
case "Maratona": return .red
case "Atividade": return .gray
case "Física": return .gray
case "Ciclismo": return .mint
case "Noturno": return .indigo
case "Show": return .purple
case "Sertanejo": return .yellow
case "Holi": return .pink
case "Cores": return .red
default: return .gray
}
}
