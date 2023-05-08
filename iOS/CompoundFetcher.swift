//
//  CompoundFetcher.swift
//  MoIZI
//
//  Created by Ongar.dev on 23/04/2023.
//

import Foundation
import SwiftUI

class CompoundFetcher: ObservableObject {
    @Published var compoundImage: Image? = nil
    
    func fetchCompoundInfo(compoundName: String) {
        let encodedCompoundName = compoundName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let pubChemApiUrl = "https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/\(encodedCompoundName)/record/PNG"
        
        guard let url = URL(string: pubChemApiUrl) else {
            print("ERROR URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("ERROR HTTP \(httpResponse.statusCode)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.processCompoundImage(data: data)
                }
            }
        }
        task.resume()
    }

    
    func processCompoundImage(data: Data) {
        if let uiImage = UIImage(data: data) {
            self.compoundImage = Image(uiImage: uiImage)
        } else {
            self.compoundImage = nil
            print("ERROR: Жүктеу сәтсіз аяқталды")
        }
    }
}

