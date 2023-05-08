import SwiftUI

struct ContentView: View {
    @State private var compoundName: String = ""
    @ObservedObject private var compoundFetcher = CompoundFetcher()
    
    var body: some View {
        ZStack {
            Color(.systemGray6) // Adding a light gray background color to fill the entire screen
            
            VStack {
                TextField("Формула немесе аты(en)", text: $compoundName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    compoundFetcher.fetchCompoundInfo(compoundName: compoundName)
                }) {
                    Text("Izdeu")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if let compoundImage = compoundFetcher.compoundImage {
                    compoundImage
                        .resizable()
                        .scaledToFit()
                        .padding()
                } else {
                    Text("Осында молекуланың құрылымы көрсетіледі")
                        .padding()
                }
            }
            .padding()
        }
    }
}

