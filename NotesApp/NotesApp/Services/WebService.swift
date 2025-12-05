//
//  WebService.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

enum NetworkError: Error {
    case badUrl
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService {
    
    // generic function to talk to api
    func sendRequest<T: Codable>(
        toURL: String,
        method: HTTPMethod,
        body: T? = nil
    ) async -> T? {
        print(" WebService: Starting request")
        print("URL: \(toURL)")
        print(" Method: \(method.rawValue)")
        
        do {
            // check url is valid
            guard let url = URL(string: toURL) else {
                print("Bad URL!")
                throw NetworkError.badUrl
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = 60  
            
        
            if let body = body {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                print(" Added request body")
            }
            
       
            print(" Sending request... ")
            let startTime = Date()
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let duration = Date().timeIntervalSince(startTime)
            print(" Got response after \(String(format: "%.1f", duration)) seconds")
            
       
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response is not HTTPURLResponse")
                throw NetworkError.badResponse
            }
            
            print(" Status code: \(httpResponse.statusCode)")
            
      
            guard 200..<300 ~= httpResponse.statusCode else {
                print(" Bad status code: \(httpResponse.statusCode)")
                throw NetworkError.badStatus
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                let preview = jsonString.prefix(500)
                print(" Raw data preview: \(preview)...")
            }
            
            print(" Decoding JSON...")
            
          
            let decoded = try JSONDecoder().decode(T.self, from: data)
            
            print(" Successfully decoded data!")
            
            return decoded
            
        } catch let decodingError as DecodingError {
          
            switch decodingError {
            case .keyNotFound(let key, let context):
                print("Decoding Error: Missing key '\(key.stringValue)'")
                print("   Context: \(context.debugDescription)")
            case .typeMismatch(let type, let context):
                print(" Decoding Error: Type mismatch for \(type)")
                print("   Context: \(context.debugDescription)")
            case .valueNotFound(let type, let context):
                print(" Decoding Error: Missing value for \(type)")
                print("   Context: \(context.debugDescription)")
            case .dataCorrupted(let context):
                print("Decoding Error: Data corrupted")
                print("   Context: \(context.debugDescription)")
            @unknown default:
                print(" Unknown decoding error: \(decodingError)")
            }
            return nil
            
        } catch {
            print(" Request failed: \(error.localizedDescription)")
            print("   Error type: \(type(of: error))")
            return nil
        }
    }
}
