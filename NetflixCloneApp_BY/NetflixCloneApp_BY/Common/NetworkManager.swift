//
//  NetworkManager.swift
//  NetflixCloneApp_BY
//
//  Created by iOS study on 5/8/25.
//  데이터를 가져올 때 중복되는 코드를 줄이기 위해 싱글톤으로 NetworkManager를 생성

import Foundation
import RxSwift

enum NetworkError: Error {
    case invalidUrl
    case dataFetchFail
    case decodeingFail
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    // URL을 파라미터로 받고, Single<T> 타입을 반환, 어떤 타입이 들어올진 모르지만 T타입이 Decodable을 만족하면 됨
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            let seesion = URLSession(configuration: .default)
            seesion.dataTask(with: URLRequest(url: url)) { data, response, error in
                
                //만약 에러라면 에러를 밷는 Single을 return
                if let error = error {
                    observer(.failure(error))
                    return
                }
                
                // 데이터를 못 불러온다면(데이터 패치 실패) 에러 표시
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }
                
                // 데이터를 잘 받아왔지만 디코딩까지 성공하면 observer(.success(decodedData)로 Single에 success로 방출(이게 반환되는 <T>타입)
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer(.success(decodedData))
                } catch {
                    observer(.failure(NetworkError.decodeingFail))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
    
}
