import SwiftUI

struct SaveView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.local.filter { $0.salvo }, id: \.self) { evento in
                        NavigationLink(destination: EventView(place: evento)) {
                            HStack {
                                Image(systemName: iconForCategory(evento.categoria))
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(colorForCategory(evento.categoria))

                                VStack(alignment: .leading) {
                                    Text(evento.nome)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    HStack {
                                        ForEach(evento.tags, id: \.self) { tag in
                                            Text(tag)
                                                .font(.caption)
                                                .padding(5)
                                                .background(colorForTag(tag: tag))
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.corItem).opacity(0.6))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .background(Color.corPersonalizada)
            .navigationTitle("Eventos Salvos")
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}
