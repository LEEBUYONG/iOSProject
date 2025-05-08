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
    
}

