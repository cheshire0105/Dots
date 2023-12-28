import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

class 캘린더_스케쥴_등록_모달 : UIViewController {
    
    var 셀_데이터_배열 = 셀_배열() {
           didSet {
               DispatchQueue.main.async {
                   self.캘린더_전시_테이블뷰.reloadData()
               }
           }
       }
    
    
    private let 손잡이 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 5
        uiView.layer.borderWidth = 0.5
        return uiView
    } ()
    private let 페이지_제목 = {
        let label = UILabel()
        label.text = "다녀온 전시 기록"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var 캘린더_전시_테이블뷰 = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(캘린더_스케쥴_등록_셀.self, forCellReuseIdentifier: "캘린더_스케쥴_등록_셀")
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        view.layer.borderWidth = 0.3
        
        UI레이아웃()
        캘린더_전시_테이블뷰.delegate = self
        캘린더_전시_테이블뷰.dataSource = self
        캘린더_전시_테이블뷰.register(캘린더_스케쥴_등록_셀.self, forCellReuseIdentifier: "캘린더_스케쥴_등록_셀")
        

    }
    override func viewWillAppear(_ animated: Bool) {
        데이터가져오기및UI업데이트()
     
    }
    deinit {
        listener?.remove()
    }
}








struct 셀_데이터 {
    var 포스터이미지URL: String
    var 전시명: String
    var 장소: String
    var 방문날짜: String
    var 리뷰문서ID: String
    var 포스터스문서ID: String

    init(포스터이미지URL: String, 전시명: String, 장소: String, 방문날짜: String, 리뷰문서ID: String,포스터스문서ID: String) {
            self.포스터이미지URL = 포스터이미지URL
            self.전시명 = 전시명
            self.장소 = 장소
            self.방문날짜 = 방문날짜
            self.리뷰문서ID = 리뷰문서ID
        self.포스터스문서ID = 포스터스문서ID

        }
}

struct 셀_배열 {
    var 셀_데이터_배열: [셀_데이터]
    
    init() {
        self.셀_데이터_배열 = [
          
        ]
    }
}

var 셀_데이터_배열 = 셀_배열()

var listener: ListenerRegistration?


extension 캘린더_스케쥴_등록_모달 {
    
    func 데이터가져오기및UI업데이트() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("유저가 접속 상태가 아님")
            return
        }
        
        let 데이터베이스 = Firestore.firestore()
        
        데이터베이스.collection("posters").addSnapshotListener { (쿼리스냅샷, 에러) in
            if let 에러 = 에러 {
                print("포스터스 문서 가져오기 에러: \(에러.localizedDescription)")
                return
            }
            
            guard let 포스터스문서들 = 쿼리스냅샷?.documents else {
                print("포스터스 문서가 없습니다.")
                return
            }
            
            for 포스터스문서 in 포스터스문서들 {
                let 포스터스문서ID = 포스터스문서.documentID
                
                데이터베이스.collection("posters").document(포스터스문서ID).collection("reviews").document(uid).addSnapshotListener { (리뷰문서스냅샷, 리뷰에러) in
                    if let 리뷰에러 = 리뷰에러 {
                        print("리뷰 문서 가져오기 에러: \(리뷰에러.localizedDescription)")
                        return
                    }
                    
                    guard let 리뷰문서데이터 = 리뷰문서스냅샷?.data(),
                          let 포스터이미지URL = 리뷰문서데이터["포스터이미지"] as? String,
                          let 방문날짜 = 리뷰문서데이터["유저_다녀옴_날짜"] as? String else {
                        return
                    }
                    let 리뷰문서ID = 리뷰문서스냅샷?.documentID ?? "" // 리뷰 문서의 ID를 가져옴

                    
                    데이터베이스.collection("전시_상세").document(포스터스문서ID).addSnapshotListener { (전시상세스냅샷, 전시에러) in
                        if let 전시에러 = 전시에러 {
                            print("전시 상세 가져오기 에러: \(전시에러.localizedDescription)")
                            return
                        }
                        
                        guard let 전시상세데이터 = 전시상세스냅샷?.data(),
                              let 전시명 = 전시상세데이터["전시_타이틀"] as? String,
                              let 전시장소 = 전시상세데이터["미술관_이름"] as? String else {
                            return
                        }
                        
                        self.다운로드된_전시_포스터_이미지(from: 포스터이미지URL) { 이미지 in
                            if 이미지 != nil {
                                let 데이터 = 셀_데이터(포스터이미지URL: 포스터이미지URL, 전시명: 전시명, 장소: 전시장소, 방문날짜: 방문날짜, 리뷰문서ID: 리뷰문서ID,                포스터스문서ID: 포스터스문서ID
)

                                if !self.셀_데이터_배열.셀_데이터_배열.contains(where: { $0.포스터이미지URL == 데이터.포스터이미지URL }) {
                                    self.셀_데이터_배열.셀_데이터_배열.append(데이터)
                                    //                                          self.캘린더_전시_테이블뷰.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func 다운로드된_전시_포스터_이미지(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let 이미지URL = URL(string: url) else {
            completion(nil)
            return
        }
        
        let 로딩중일때_나올_이미지 = UIImage(named: "기본프로필사진")
        SDWebImageManager.shared.loadImage(with: 이미지URL, options: [], progress: nil) { (image, _, _, _, _, _) in
            DispatchQueue.main.async {
                completion(image ?? 로딩중일때_나올_이미지)
            }
        }
    }
    func 셀데이터배열조회() {
           guard let uid = Auth.auth().currentUser?.uid else {
               print("유저가 접속 상태가 아님")
               return
           }

           let 데이터베이스 = Firestore.firestore()
           let postersCollection = 데이터베이스.collection("posters")

           listener = postersCollection.addSnapshotListener { (쿼리스냅샷, 에러) in
               guard let 쿼리스냅샷 = 쿼리스냅샷 else {
                   print("쿼리 스냅샷이 nil입니다. 에러: \(에러?.localizedDescription ?? "알 수 없음")")
                   return
               }

               var 업데이트된셀데이터배열 = [셀_데이터]()

               for 문서 in 쿼리스냅샷.documents {
                   let documentID = 문서.documentID
                   let newData = 문서.data()
                   print("문서 ID: \(documentID), 업데이트된 데이터: \(newData)")

                   if let 포스터이미지URL = newData["포스터이미지"] as? String,
                      let 방문날짜 = newData["유저_다녀옴_날짜"] as? String {
                       let 리뷰문서ID = documentID
                       let 포스터스문서ID = "포스터스문서의ID"

                       let 업데이트된셀데이터 = 셀_데이터(포스터이미지URL: 포스터이미지URL, 전시명: "", 장소: "", 방문날짜: 방문날짜, 리뷰문서ID: 리뷰문서ID, 포스터스문서ID: 포스터스문서ID)

                       업데이트된셀데이터배열.append(업데이트된셀데이터)
                   }
               }

               self.셀_데이터_배열.셀_데이터_배열.append(contentsOf: 업데이트된셀데이터배열)
           }
       }
}
//
//
//
//
//
//
//


extension 캘린더_스케쥴_등록_모달: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 셀_데이터_배열.셀_데이터_배열.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "캘린더_스케쥴_등록_셀", for: indexPath) as? 캘린더_스케쥴_등록_셀 else {
            return UITableViewCell()
        }
        
        let 데이터 = 셀_데이터_배열.셀_데이터_배열[indexPath.row]
        cell.전시_포스터_이미지(from: 데이터.포스터이미지URL)
        cell.전시명_라벨.text = 데이터.전시명
        cell.장소_라벨.text = 데이터.장소
        cell.방문날짜_라벨.text = 데이터.방문날짜
        if cell.isSelected {
            cell.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        print("셀클릭")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let 수정 = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            
            print("수정 버튼 클릭")
            
            let 선택된데이터 = self.셀_데이터_배열.셀_데이터_배열[indexPath.row]
                  print("-----전달될 셀 데이터-----")
                  print("포스터이미지URL: \(선택된데이터.포스터이미지URL)")
                  print("전시명: \(선택된데이터.전시명)")
                  print("장소: \(선택된데이터.장소)")
                  print("방문날짜: \(선택된데이터.방문날짜)")
                  print("리뷰문서ID: \(선택된데이터.리뷰문서ID)")
                  print("포스터스문서ID: \(선택된데이터.포스터스문서ID)")
            
            if let 현제모달 = self.findViewController() {
                현제모달.dismiss(animated: true) {
                    let 새모달 = 켈린더_수정_뷰컨트롤러()
                    
                    새모달.수정할셀데이터 = 선택된데이터

                    새모달.modalPresentationStyle = .fullScreen
                    현제모달.present(새모달, animated: false, completion: nil)
                }
            }
            
            completionHandler(true)
        }
        수정.image = UIImage(named: "내후기edit")
        수정.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        
        let 삭제 = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            print("삭제 버튼 클릭")
            
           
//               let 선택된데이터 = self.셀_데이터_배열.셀_데이터_배열[indexPath.row]
//
//               let 데이터베이스 = Firestore.firestore()
//               let uid = Auth.auth().currentUser?.uid ?? ""
//               let 포스터스문서ID = "포스터스문서의ID"
//               let 리뷰문서ID = 선택된데이터.리뷰문서ID
//               let 리뷰문서참조 = 데이터베이스.collection("posters").document(포스터스문서ID).collection("reviews").document(리뷰문서ID)
//               
//               리뷰문서참조.delete { error in
//                   if let error = error {
//                       print("리뷰 문서 삭제 에러: \(error.localizedDescription)")
//                   } else {
//                       print("리뷰 문서 삭제 성공")
//
//                       self.셀_데이터_배열.셀_데이터_배열.remove(at: indexPath.row)
//                       self.캘린더_전시_테이블뷰.reloadData()
//                   }
//               }
//
            let 선택된데이터 = self.셀_데이터_배열.셀_데이터_배열[indexPath.row]
                  print("-----전달될 셀 데이터-----")
                  print("포스터이미지URL: \(선택된데이터.포스터이미지URL)")
                  print("전시명: \(선택된데이터.전시명)")
                  print("장소: \(선택된데이터.장소)")
                  print("방문날짜: \(선택된데이터.방문날짜)")
                  print("리뷰문서ID: \(선택된데이터.리뷰문서ID)")
                  print("포스터스문서ID: \(선택된데이터.포스터스문서ID)")
            
            
            if let 현제모달 = self.findViewController() {
                현제모달.dismiss(animated: true) {
                    let 새모달 = 켈린더_삭제_뷰컨트롤러()
                    새모달.modalPresentationStyle = .fullScreen
                    현제모달.present(새모달, animated: false, completion: nil)
                    
                }
            }
            
            completionHandler(true)
        }
        삭제.image = UIImage(named: "내후기delete")
        삭제.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        
        let configuration = UISwipeActionsConfiguration(actions: [삭제, 수정])
        수정.accessibilityValue = "수정 버튼"
        삭제.accessibilityValue = "삭제 버튼"
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        tableView.separatorStyle = .none
    }
}


extension 캘린더_스케쥴_등록_모달 {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
}


extension 캘린더_스케쥴_등록_모달 {
    
    private func UI레이아웃 () {
        view.addSubview(손잡이)
        view.addSubview(페이지_제목)
        view.addSubview(캘린더_전시_테이블뷰)
        
        손잡이.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalTo(손잡이.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        캘린더_전시_테이블뷰.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}


