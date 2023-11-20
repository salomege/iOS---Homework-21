//
//  ViewController.swift
//  Homework_21
//
//  Created by salome on 20.11.23.
//
import CatFactsPackage

CatFactsFetcher.fetch { result in
    switch result {
    case .success(let catFactResponse):
        let catFact = catFactResponse.data.first?.fact ?? "No cat facts available."
        print(catFact)
    case .failure(let error):
        print("Error fetching cat facts: \(error.localizedDescription)")
    }
}
