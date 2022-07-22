//
//  NetworkManager.swift
//  CodingChallenge
//
//  Created by Naveen Nallamothu on 07/21/22.
//
import Foundation
enum HTTPMethod:String {
    case GET
    case POST
    case PUT
    case DELETE
}
class NetworkManager: NSObject {
    static var sharedInstance = NetworkManager()
    func requestWithModel<T:Codable>(urlString: String, method: HTTPMethod, model: T.Type, completion: ((_ response: OutputResponse<T>)->())?) {
        
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        guard let url = URL(string: encodedUrlString) else {
            let finalOutput = OutputResponse<T>()
            let responseModel = finalOutput.decodableData(responseData: nil)
            responseModel.message = "Empty Url"
            responseModel.success = false
            responseModel.statusCode = 404
            completion?(responseModel)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let finalOutput = OutputResponse<T>()
            let responseModel = finalOutput.decodableData(responseData: data)
            responseModel.message = error?.localizedDescription ?? "Success"
            responseModel.statusCode = (response as? HTTPURLResponse)?.statusCode ?? 404
            if error == nil {
                responseModel.success = true
            } else {
                responseModel.success = false
            }
            completion?(responseModel)
        }).resume()
    }
}

public class OutputResponse<T:Codable>: NSObject {
    public var success: Bool = false
    public var message: String = ""
    public var model: T?
    public var statusCode = 404
    
    public override init() {
        super.init()
    }
    
    func decodableData(responseData: Data?) -> OutputResponse {
        if let rawdata = responseData {
            let decoder = JSONDecoder()
            do {
                let decodedValue = try decoder.decode(T.self, from: rawdata)
                self.model = decodedValue
            } catch let error {
                print(error.localizedDescription)
            }
        } else {}
        return self
    }
}
