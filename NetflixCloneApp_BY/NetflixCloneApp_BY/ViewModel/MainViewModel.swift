//
//  MainViewModel.swift
//  NetflixCloneApp_BY
//
//  Created by iOS study on 5/8/25.
//  서버로부터 데이터를 불러오는 비즈니스 로직 작성

import UIKit
import RxSwift

class MainViewModel {
    private let apiKey = "de77c9b9cdd46c2cc85f038a2b0d2003"
    private let disposeBag  = DisposeBag() /// 구독 해제 했을때 담아줄 가~방
    
    // View가 구독할 Subject (옵저버 패턴 활용)
    // MainVC에서 MainVM에 있는 Subject들(Ovserverble) 구독하고, Subject들이 값을 방출했을 때 동작할 수 있도록 선언함
    let popluarMovieSubject = BehaviorSubject(value: [Movie]())
    let topRatedMovieSubject = BehaviorSubject(value: [Movie]())
    let upcomingMovieSubject = BehaviorSubject(value: [Movie]())
    
    init() {
        fetchPoppularMovie()
        fetchTopRatedMovie()
        fetchUpcomingMovie()
    }
    
    // Populatr Move 데이터를 불러옴
    func fetchPoppularMovie() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
            popluarMovieSubject.onError(NetworkError.invalidUrl)
            return
        }
        
        // url 성공 시 movieResponse 타입으로 받아들이겠다는 것
        // 결과가 Single 타입이었으니까 구독해서 NewtworkManager가 값을 방출하면 성공여부에 따라 success, error 각 로직이 실행됨
        NetworkManager.shared.fetch(url: url)
        // 성공 시 MovieResponse로 값이 들어오고 거기에서 movie에 대한 리스트를 제공해주고 있기 때문에 result List들을 popluarMovieSubject 안에 넣음
            .subscribe(onSuccess: { [weak self] (movieResponse: MovieResponse) in
                self?.popluarMovieSubject.onNext(movieResponse.results)
            }, onFailure: { [weak self] error in
                self?.popluarMovieSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    // TopRated Move 데이터를 불러옴
    func fetchTopRatedMovie() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)") else {
            topRatedMovieSubject.onError(NetworkError.invalidUrl)
            return
        }
        
        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (movieResponse: MovieResponse) in
                self?.topRatedMovieSubject.onNext(movieResponse.results)
            }, onFailure: { [weak self] error in
                self?.topRatedMovieSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    // Upcoming Move 데이터를 불러옴
    func fetchUpcomingMovie() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") else {
            upcomingMovieSubject.onError(NetworkError.invalidUrl)
            return
        }
        
        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (movieResponse: MovieResponse) in
                self?.upcomingMovieSubject.onNext(movieResponse.results)
            }, onFailure: { [weak self] error in
                self?.upcomingMovieSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    // 트레일러 영상을 가져오기 위한 fetch 메서드
    func fetchTrailerKey(movie: Movie) -> Single<String> {
        guard let movieId = movie.id else { return Single.error(NetworkError.dataFetchFail)}
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Single.error(NetworkError.invalidUrl)
        }
        
        // 가져온 API 데이터를 Single에 String 타입으로 return 타입을 바꿈 (flatMap 사용)
        // 원래 Single<VideoResponse>인데 flatMap을 사용하면 Single<String>으로 변환 가능
        return NetworkManager.shared.fetch(url: url)
            .flatMap { (VideoRespons: VideoResponse) -> Single<String> in
                // rseults 중에 가장 첫번째 원소(여러 트레일러 중 첫번째 트러일러)를 보겠다
                // where: 을 통해 Response 중에 site, type도 같이 확인해서 체크함
                if let trailer = VideoRespons.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube"}) {
                    // fetchTrailerKey의 return 타입은 String 키를 뱉을 수 있도록(key: String Type) Single에 just(key)로 넣어줌
                    guard let key = trailer.key else { return Single.error(NetworkError.dataFetchFail) }
                    return Single.just(key)
                } else {
                    return Single.error(NetworkError.dataFetchFail)
                }
            }
    }
}

