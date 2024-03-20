import Foundation

// MARK: - Data getting

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
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
            print("Response code: \(response.statusCode)")
            if response.statusCode == 200 {
                guard let data = data else { return }
                let dataAsString = String(data: data, encoding: .windowsCP1251)
                guard let dataAsString = dataAsString else { return }
                print(dataAsString)
            } else if response.statusCode == 404 {
                print("Page not found. Check url request string.")
            }
        }
    }.resume()
}

// MARK: - Use case

let currentDate = Date.getCurrentDate()
let urlRequest = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=\(currentDate)"
let urlRequest404 = "http://www.cbr.ru/sc/XML_daily.asp?date_req=\(currentDate)"
let urlRequestHostNotFound = "http://www.cb.ru/scripts/XML_daily.asp?date_req=\(currentDate)"
let urlRequestBadParameter = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=01/01/1970"

getData(urlRequest: urlRequest)
