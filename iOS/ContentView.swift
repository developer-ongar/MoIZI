import SwiftUI

struct ContentView: View {
    @State private var compoundName: String = ""
    @ObservedObject private var compoundFetcher = CompoundFetcher()
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    TextField("Іздеу", text: $compoundName)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(8)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        compoundFetcher.fetchCompoundInfo(compoundName: compoundName)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                if let compoundImage = compoundFetcher.compoundImage {
                    compoundImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal)
                } else {
                    Text("Химиялық қосылыстың формуласын немесе атын ағылшын әріптерімен жазыңыз.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

