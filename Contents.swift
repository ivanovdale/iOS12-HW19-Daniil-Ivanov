import Foundation

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
        if let error = error as? URLError {
            print("Error occured.")
            switch error.code {
            case .notConnectedToInternet:
                print("The Internet connection appears to be offline. Please reconnect")
            case .cannotFindHost:
                let host = url.host ?? "Unknown"
                print("Cannot find host \(host)")
            default: print("An error occurred: \(error.localizedDescription)")
            }
        } else if let response = response as? HTTPURLResponse {
                let dataAsString = String(data: data, encoding: .windowsCP1251)
        }
    }.resume()
}
