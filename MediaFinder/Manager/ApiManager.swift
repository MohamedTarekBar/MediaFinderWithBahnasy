
import UIKit
import Alamofire

class ApiManager {
    
    static func mediaLoad (dataType: String, searchText: String, completion: @escaping (Result<ItunesMedia,Error>) -> ()) {
    
        AF.request("https://itunes.apple.com/search?", method: .get, parameters: ["term" :searchText, "media" : dataType], encoding: URLEncoding.default, headers: nil).response {
        response in
            
            do {
                guard let data = response.data else {
                    print("no data found")
                    return}
                let media = try JSONDecoder().decode(ItunesMedia.self, from: data)
                completion(.success(media))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
    }
}


