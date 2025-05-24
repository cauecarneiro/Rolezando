import SwiftUI

struct EventView: View {
    var place: Local
    @StateObject var viewModel = ViewModel()
    @State var nomeAux: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Topo com imagem e botão voltar
            Rectangle()
                .frame(width: 375, height: 250)
                .overlay {
                    AsyncImage(url: URL(string: place.imagem_url)) {image in
                            image.resizable()
                           // .scaledToFill()
                    } placeholder: {
                        AsyncImage(url: URL(string: "https://static.vecteezy.com/system/resources/thumbnails/008/174/698/small/animation-loading-circle-icon-loading-gif-loading-screen-gif-loading-spinner-gif-loading-animation-loading-on-black-background-free-video.jpg")) {image in
                            image.resizable()
                          //  .scaledToFill()
                    } placeholder: {
                       ProgressView()
                    }
                    }
                }

            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Text(place.nome)
                    Spacer()
                    
//                    Image(systemName: "bookmark")
//                        .font(.largeTitle)
//                        .foregroundColor(.green)
                    
                    
                    if place.salvo == true{
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "bookmark")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                }
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .padding(.leading,5)
                .foregroundColor(.white)
                
//                Text(place.data)
//                    .foregroundColor(.white)
                
                // Tags
                HStack {
                    ForEach(place.tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(colorForTag(tag: tag))
                            .cornerRadius(20)
                            .foregroundColor(.white)
                    }
                }
                .padding(.leading,5)
                
                // Card de evento
                        VStack(alignment: .leading, spacing: 20) {
                            
                            HStack{
                                Image(systemName: "flame.fill").foregroundColor(.black)
                                Text(place.descricao).foregroundStyle(.black)
                            }
                            
//                            HStack {
//                                Label("Teste", systemImage: "clock.fill")
//                                Spacer()
//                                Label("Teste", systemImage: "ticket.fill")
//                            }
//                            
//                            HStack {
//                                Image(systemName: "music.note")
//                                Text("Teste")
//                            }
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("4.8").foregroundColor(.black)
                            }
                            
                            HStack{
                                Image(systemName: "mappin.and.ellipse").foregroundColor(.red)
                                Text(place.localizacao.endereco).foregroundStyle(.black)
                            }.font(.subheadline)
                            Spacer()
                        }.padding()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(radius: 5)
            }

            Spacer()

            // Tab bar
           
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.corPersonalizada)
        
        
        //CRIAR BANCO SÓ DE FAVORITO
        //FAZER POST SÓ DE UM ARRAY LOCAL
    }
}

#Preview {
    EventView(place: Local(_id: "", _rev: "", categoria: "Festa", nome: "Festa Sunset", data: "2025-08-10", localizacao: Loc(local: "Arena Hall", endereco: "SHS Quadra 6 Bloco E, Brasília - DF, 70316-000", latitude: -15.7877, longitude: -47.8901), descricao: "Festa ao pôr do sol com DJ internacional.", tags: ["Eletrônica", "DJ", "Funk"], salvo: true, imagem_url: ""))
}
