//
//  NetworkManager.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//

import Foundation
import Alamofire
import UIKit

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    static let urlToServer = "http://127.0.0.1:5000/"
    
    func getItems(item: String, from store: String, completion: @escaping (Clothing) -> Void) {
        let urlPath = NetworkManager.urlToServer + "getitems/" + item + "/" + store
        let request = AF.request(urlPath)
        request.responseDecodable(of: Clothing.self) { (response) in
            guard let clothing = response.value else { return }
            completion(clothing)
        }
    }
    
    func getItems(item: String, completion: @escaping (Clothing) -> Void) {
        let urlPath = NetworkManager.urlToServer + "getitemsonly/" + item
        let request = AF.request(urlPath)
        request.responseDecodable(of: Clothing.self) { (response) in
            guard let clothing = response.value else { return }
            completion(clothing)
        }
    }
    
    func getLastFetchedItems(completion: @escaping (FoundApparel) -> Void) {
        let urlPath = NetworkManager.urlToServer + "getlastitems"
        let request = AF.request(urlPath)
        request.responseDecodable(of: FoundApparel.self) { (response) in
            guard let clothing = response.value else { return }
            completion(clothing)
        }
    }
    
    func uploadPhotoToServer(_ imageData: Data, completion: @escaping ((UIImage) -> Void)) {
        let api_url = NetworkManager.urlToServer + "/upload"
        guard let url = URL(string: api_url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        AF.upload(multipartFormData: { multiPart in
            multiPart.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            if let imageData = data.data {
                if let image = UIImage(data: imageData) {
                    completion(image)
                } else {
                    print("❌❌❌")
                }
            }
        })
    }
}
