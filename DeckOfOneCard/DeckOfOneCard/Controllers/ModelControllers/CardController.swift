//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Michael Nguyen on 11/17/20.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")
    static let drawComponent = "new/draw/"
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion (.failure(.invalidURL))}
        let componentURL = baseURL.appendingPathComponent(drawComponent)
        var components = URLComponents(url: componentURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [URLQueryItem(name: "count", value: "1")]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("An error has occurred")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else {
                    return completion(.failure(.noData))
                }
                return completion(.success(card))
            } catch {
                return completion(.failure(.noData))
            }
        } .resume()
    }
    static func fetchImage(card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        let url = card.image
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("An error has occurred")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return
                completion(.failure(.unableToDecode))}
            return completion(.success(image))
        } .resume()
    }
}
