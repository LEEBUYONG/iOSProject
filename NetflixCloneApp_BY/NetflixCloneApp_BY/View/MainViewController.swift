//
//  ViewController.swift
//  NetflixCloneApp_BY
//
//  Created by iOS study on 5/8/25.
//

import AVKit
import AVFoundation
import UIKit

import SnapKit
import RxSwift
import Then

class MainViewController: UIViewController {
    
    // MainVM을 바라보기 위한 VM선언
    private let mainVM = MainViewModel()
    
    private let disposeBag = DisposeBag()
    
    private var popularMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var upcomingMovies = [Movie]()
    
    private let label = UILabel().then {
        $0.text = "NETFLIX"
        $0.textColor = UIColor(red: 229/255, green: 9/255, blue: 20/255, alpha: 1.0)
        $0.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.id)
        $0.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureUI()
    }
    
    // VM과 VC를 연결하기 위한 데이터 바인딩 메서드
    private func bind() {
        // VM에서 fetchPopulerMovie()가 실행되면 서버로부터 영화 정보를 가져오고 subject 안에 넣어서 onNext()를 통해 방출되도록 설정
        // 그리고 Subject를 구독을 하게 된다면 서버에서 해당 데이터가 들어왔을 때 방출된 구독한 View가 이벤트를 받게됨
        mainVM.popluarMovieSubject
            .observe(on: MainScheduler.instance)        //reloadData는 UI 관련 로직으로 해당 코드가 메인스레드에서 동작할 수 있도록 함
            .subscribe(onNext: { [weak self] movies in
                self?.popularMovies = movies
                self?.collectionView.reloadData()
            }, onError: { error in
                print("에러발생: \(error)")
            }).disposed(by: disposeBag)
        
        mainVM.topRatedMovieSubject
            .observe(on: MainScheduler.instance)        //reloadData는 UI 관련 로직으로 해당 코드가 메인스레드에서 동작할 수 있도록 함
            .subscribe(onNext: { [weak self] movies in
                self?.topRatedMovies = movies
                self?.collectionView.reloadData()
            }, onError: { error in
                print("에러발생: \(error)")
            }).disposed(by: disposeBag)
        
        mainVM.upcomingMovieSubject
            .observe(on: MainScheduler.instance)        //reloadData는 UI 관련 로직으로 해당 코드가 메인스레드에서 동작할 수 있도록 함
            .subscribe(onNext: { [weak self] movies in
                self?.upcomingMovies = movies
                self?.collectionView.reloadData()
            }, onError: { error in
                print("에러발생: \(error)")
            }).disposed(by: disposeBag)
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        // 각 item이 각 그룹 내에서 전체 넓이와 높이를 차지하도록 설정(1.0 = 100%)
        let itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 각 그룹에 대한 넓이는 화면 넓이 25%, 높이는 넓이의 25%를 차지하도록 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(0.25)
        )
        
        // 그룹이 수평적으로 구성되도록 선언 (horizontal)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous   /// 스크롤이 수평방향으로 연속적으로 동작할 수 있도록 설정
        section.interGroupSpacing = 10                      /// 그룹 안에 아이템들 간의 간격(spacing)이 10이다
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)   /// 각 섹션간의 inset 지정
        
        
        // 헤더 사이즈와 설정 지정
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // 섹션에 우리가 만든 헤더 추가
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        [label, collectionView].forEach { view.addSubview($0) }
        
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // 동영상 재생을 위한 메서드 (YouTubeiOSPlayerHelper를 사용하기 때문에 아래 메서드는 사용 x)
    // 다만 YouTubeiOSPlayerHelper를 사용하는 것이 아닌 실제 회사나 url을 통해 동영상 데이터를 내려받을 때는
    // 아래와 같은 방식으로 url을 넣어서 AVPlayer와 AVPlayerViewController을 통해 동영상을 재생하게 됨
    private func playVideoUrl() {
        
        let url = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4")!

        // url을 AVPlayer객체에 담아서 동영상으로 만드는 것
        let player = AVPlayer(url: url)
        
        let playerVC = AVPlayerViewController()
        
        playerVC.player = player
        
        present(playerVC, animated: true) {
            player.play()
        }
    }
    
}

// 섹션을 좀 더 쉽게 구별하기 위해 enum 사용
// CaseIterable을 사용해서 각 case에 0,1,2번째로 Index 순서가 매겨짐
enum Section: Int, CaseIterable {
    case popularMovies
    case topRatedMovies
    case upcomingMovies
    
    var title: String {
        switch self {
        case .popularMovies: return "이 시간 핫한 영화"
        case .topRatedMovies: return "가장 평점이 높은 영화"
        case .upcomingMovies: return "곧 개봉되는 영화"
        }
    }
}

// 컬렉션뷰 셀을 클릭했을때 동영상이 재생되는 로직
extension MainViewController: UICollectionViewDelegate {
    // 아이템을 클릭했을 때 반응하는 메서드 (Switch로 각 섹션에 해당한 로직이 수행)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .popularMovies:
            // popularMovies의  indexPath에 해당하는 0번째 movie data를 값을 가져옴
            // 그리고 그 정보를 fetchTrailerKey해서 movieid를 얻고, url에 네트워크를 요청해서 동영상 키값을 받아와서 비디오를 재생시킴
            // 또한 해당하는 동영상 키값 트레일러를 YouTubeiOSPlayerHelper를 사용해서 새 페이지로 열어서 보여주게됨
            mainVM.fetchTrailerKey(movie: popularMovies[indexPath.row])
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] key in
                    self?.navigationController?.pushViewController(YoutubeViewController(key: key), animated: true)
                }, onFailure: { error in
                    print("에러발생: \(error)")
                }).disposed(by: disposeBag)
            
        case .topRatedMovies:
            mainVM.fetchTrailerKey(movie: topRatedMovies[indexPath.row])
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] key in
                    self?.navigationController?.pushViewController(YoutubeViewController(key: key), animated: true)
                }, onFailure: { error in
                    print("에러발생: \(error)")
                }).disposed(by: disposeBag)
            
        case .upcomingMovies:
            mainVM.fetchTrailerKey(movie: upcomingMovies[indexPath.row])
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] key in
                    self?.navigationController?.pushViewController(YoutubeViewController(key: key), animated: true)
                }, onFailure: { error in
                    print("에러발생: \(error)")
                }).disposed(by: disposeBag)
        default:
            return
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    // 각 indexPath 별로 어떤 Cell을 return 할건지, tableView의 cellForRowAt과 비슷한 역할, 섹션 별로 나눌 수 있음
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.id, for: indexPath) as? PosterCell else {
            return UICollectionViewCell()
        }
        
        switch Section(rawValue: indexPath.section) {
            // 각 셀에 포스터를 포함한 Movie 데이터를 서버에서 받아서 넣으면 됨
        case .popularMovies:
            cell.configure(with: popularMovies[indexPath.row])
        case .topRatedMovies:
            cell.configure(with: topRatedMovies[indexPath.row])
        case .upcomingMovies:
            cell.configure(with: upcomingMovies[indexPath.row])
        default :
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //kind 종류가 header일 경우만 코드를 읽겠다는 의미
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.id,
            for: indexPath
        ) as? SectionHeaderView else { return UICollectionReusableView() } // 섹션 헤더뷰로 타입캐스팅하고 만약 실패시 UICollectionReusableView(Default 값)를 리턴
        
        // allCases는 Setion의 모든 case를 List로 뽑아냄
        // Caselterable 프로토콜을 채택해서 allCases 프로퍼티 사용이 가능함
        let sectionType = Section.allCases[indexPath.section]
        
        // case에 따라 헤더에 StringValur로 return 됨 (titleLabel에 text가 됨)
        headerView.configure(title: sectionType.title)
        return headerView
    }
    
    // 각 섹션마다 아이템이 몇개 있는지 지정해주는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .popularMovies: return popularMovies.count
        case .topRatedMovies: return topRatedMovies.count
        case .upcomingMovies: return upcomingMovies.count
        default : return 0
        }
    }
    
    // collectionView의 섹션이 몇개인지 설정(Section case의 개수를 세면 됨)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}
