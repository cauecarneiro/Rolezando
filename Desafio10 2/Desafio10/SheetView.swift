import SwiftUI

struct SheetView: View {
    @StateObject private var coisas = ViewModel()
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.gray)
                .padding(.top, 8)
            
            HStack{
                VStack(alignment: .leading, spacing: 4) {
                    Text("Em alta no momento")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                    
                    Text("Na sua região: Plano Piloto")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            
            }
            .padding(.leading, 20)
            .padding(.top, 8)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(coisas.local.prefix(5), id: \.self) { lugar in
                        NavigationLink(destination: EventView(place: lugar)){
                            HStack{
                                Image(systemName: iconForCategory(lugar.categoria))
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(colorForCategory(lugar.categoria))
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(lugar.nome)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 4) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.green)
                                            Text("3,6")
                                                .foregroundColor(.green)
                                                .font(.subheadline)
                                        }
                                    }
                                    
                                    HStack {
                                        ForEach(lugar.tags, id: \.self) { tag in
                                            Text(tag)
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(colorForTag(tag: tag))
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.corItem).opacity(0.6))
                            .cornerRadius(12)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.corPersonalizada)
        .cornerRadius(20)
        .shadow(radius: 10)
        .onAppear {
            coisas.fetch()
        }
    }
    
    private func tagBackgroundColor(for tag: String) -> Color {
        switch tag {
        case "Balada": return .green
        case "Funk": return .blue
        case "Evento Tech": return .yellow
        case "Cultura": return .cyan
        case "Esporte": return .purple
        case "Ao Ar Livre": return .red
        case "Restaurante": return .orange
        case "Regional": return .green
        default: return .gray
        }
    }
}

#Preview {
    SheetView()
}
