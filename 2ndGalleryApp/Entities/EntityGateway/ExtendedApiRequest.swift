//
//  ExtendedApiRequest.swift
//  2ndGalleryApp
//
//  Created by Роман on 30.06.2021.
//

import RxNetworkApiClient

class ExtendedApiRequest<T: Codable>: ApiRequest<T> {
  
    override init(_ endpoint: ApiEndpoint) {
        super.init(endpoint)
        super.responseTimeout = 15
    }
    
    override var request: URLRequest {
        var request = URLRequest(url: URL(string: endpoint.host)!)
        request.httpMethod = method?.rawValue
        
        // Body construction
        if let body = self.body {
            request.httpBody = body.createBody()
        } else {
            // Form data construction
            if (files == nil || files?.isEmpty == true), let formData = formData {
                request.httpBody = formData.compactMap { key, value -> String in
                    return "\(key)=\(value ?? "")"
                }.joined(separator: "&").data(using: .utf8)
            }
            // SET FILES
            if let files = files {
                var body = Data()
                
                let boundary = UUID().uuidString
                
                files.forEach { file in
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(file.name)\"\r\n")
                    body.appendString("Content-Type: \(file.mimeType)\r\n\r\n")
                    body.append(file.data)
                    body.appendString("\r\n")
                }
                if let formData = formData {
                    formData.forEach { key, value in
                        body.appendString("--\(boundary)\r\n")
                        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                        body.appendString("\(value ?? "null")\r\n")
                    }
                }
                
                body.appendString("--\(boundary)--\r\n")
                
                request.setValue("multipart/form-data; boundary=\(boundary)",
                    forHTTPHeaderField: "Content-Type")
                request.httpBody = body
            }
        }
        
        if let headers = self.headers {
            request.allHTTPHeaderFields = headers.toMap()
        }
        
        let endpointPart = endpoint.host
        let pathPart = path ?? ""
        let queryPart = query?.toString() ?? ""
        request.url = URL(string: endpointPart + pathPart + queryPart)!
        request.timeoutInterval = self.responseTimeout
        return request
    }
   
    static func extendedRequest<T: Codable>(
        path: String? = nil,
        method: HttpMethod,
        endpoint: ApiEndpoint = ApiEndpoint.baseEndpoint,
        headers: [Header]? = nil,
        formData: FormDataFields? = nil,
        files: [UploadFile]? = nil,
        body: BodyConvertible? = nil,
        queryArray: QueryField...) -> ExtendedApiRequest<T> {
        
        return ExtendedApiRequest.extendedRequest(path: path,
                                                         method: method,
                                                         endpoint: endpoint,
                                                         headers: headers,
                                                         formData: formData,
                                                         files: files,
                                                         body: body,
                                                         queryArray: queryArray)
    }
    
    static func extendedRequest<T: Codable>(
        path: String? = nil,
        method: HttpMethod,
        endpoint: ApiEndpoint = ApiEndpoint.baseEndpoint,
        headers: [Header]? = nil,
        formData: FormDataFields? = nil,
        files: [UploadFile]? = nil,
        body: BodyConvertible? = nil,
        queryArray: [QueryField]) -> ExtendedApiRequest<T> {
        
        let request = ExtendedApiRequest<T>(endpoint)
        request.path = path
        request.method = method
        request.endpoint = endpoint
        request.headers = headers
        request.formData = formData
        request.files = files
        request.body = body
        request.query = queryArray
        return request
    }
    
}

fileprivate extension Data {
    
    mutating func appendString(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: false)
        self.append(data!)
    }
}

fileprivate extension Array where Element == QueryField {
    
    func toString() -> String {
        var allowedSymbols = CharacterSet.alphanumerics
        allowedSymbols.insert(charactersIn: "-._~&=") // as per RFC 3986
        allowedSymbols.remove("+")
        
        if !self.isEmpty {
            let flatStringQuery = self.filter({ $0.1?.isEmpty == false })
                .compactMap({ "\($0)=\($1!)" })
                .joined(separator: "&")
                .addingPercentEncoding(withAllowedCharacters: allowedSymbols)!
            return "?\(flatStringQuery)"
        }
        return ""
    }
}
