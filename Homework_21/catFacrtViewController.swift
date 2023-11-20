//
//  catFacrtViewController.swift
//  Homework_21
//
//  Created by salome on 20.11.23.
//

import UIKit

class catFactViewController: UIViewController {

    @IBOutlet private weak var catFactLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cat Facts"
        fetchData() // Call the fetchData method when the view loads
    }

    private func fetchData() {
        guard let url = URL(string: "https://catfact.ninja/facts?limit=1") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching cat facts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                let catFactResponse = try decoder.decode(CatFactResponse.self, from: data)
                let catFact = catFactResponse.data.first?.fact ?? "No cat facts available."
                
                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.catFactLabel.text = catFact
                }
            } catch {
                print("Error decoding cat facts: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct CatFact: Codable {
    let fact: String
}

struct CatFactResponse: Codable {
    let data: [CatFact]
}
