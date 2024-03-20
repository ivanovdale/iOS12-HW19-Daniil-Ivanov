import Foundation

// MARK: - Use case

let client = HTTPClient()

// MARK: - Get currency data

let cbrApi = CBRApi(client: client)
let currentDate = Date.getCurrentDate()
cbrApi.getCurrencyExchangeList(dateString: currentDate)
cbrApi.getFakeResource()
cbrApi.getHostNotFound()
cbrApi.getCurrencyExchangeListWithBadParameter()

getData(urlRequest: urlRequest)
