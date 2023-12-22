import UIKit
import FSCalendar
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage


extension Mypage: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        calendar.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if 유저_다녀옴_날짜.contains(where: { Calendar.current.isDate(date, inSameDayAs: $0) }) {
            return nil
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at 포스터이미지_등록할_특정날짜: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: 포스터이미지_등록할_특정날짜)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if 포스터이미지_등록할_특정날짜 == .current, let cell = cell as? FSCalendarCell, 유저_다녀옴_날짜.contains(where: { Calendar.current.isDate(date, inSameDayAs: $0) }) {
            
            if cell.subviews.filter({ $0 is UIButton }).isEmpty {
                let 날짜에_등록할_이미지 = UIButton(type: .custom)
                
                if let 특정날짜 = 특정날짜.first(where: { $0.date == dateFormatter.string(from: date) }) {
                    if let imageURLString = 특정날짜.imageURL, let imageURL = URL(string: imageURLString) {
                        날짜에_등록할_이미지.sd_setImage(with: imageURL, for: .normal)
                    }
                    else {
                        날짜에_등록할_이미지.setImage(UIImage(named: "기본프로필사진"), for: .normal)
                    }
                }
                
                날짜에_등록할_이미지.layer.borderWidth = 1
                날짜에_등록할_이미지.layer.borderColor = UIColor.white.cgColor
                날짜에_등록할_이미지.clipsToBounds = true
                날짜에_등록할_이미지.layer.masksToBounds = true
                날짜에_등록할_이미지.layer.cornerRadius = 20
                날짜에_등록할_이미지.isUserInteractionEnabled = true
                
                날짜에_등록할_이미지.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)

                
                cell.addSubview(날짜에_등록할_이미지)
                날짜에_등록할_이미지.snp.makeConstraints { make in
                    make.centerX.equalTo(cell.snp.centerX)
                    make.centerY.equalTo(cell.snp.centerY).offset(-5)
                    make.size.equalTo(40)
                }
                캘린더.reloadData()
                
            }
        } else {
            cell.subviews.filter { $0 is UIButton }.forEach { $0.removeFromSuperview() }
        }
        
        return cell
    }
    @objc func imageButtonTapped() {
        print("이미지 클릭됨")
        
        // 캘린더_스케쥴_등록_모달 띄우기
        let 캘린더_스케쥴_등록_모달 = 캘린더_스케쥴_등록_모달()
        
        if let sheetPresent = 캘린더_스케쥴_등록_모달.presentationController as? UISheetPresentationController {
            sheetPresent.prefersGrabberVisible = true
            sheetPresent.detents = [.medium(), .large()]
            캘린더_스케쥴_등록_모달.isModalInPresentation = false
            sheetPresent.largestUndimmedDetentIdentifier = .large
            sheetPresent.prefersScrollingExpandsWhenScrolledToEdge = true
            sheetPresent.preferredCornerRadius = 30
            sheetPresent.prefersGrabberVisible = false
        }
        
        캘린더_스케쥴_등록_모달.modalPresentationStyle = .pageSheet
        self.present(캘린더_스케쥴_등록_모달, animated: true, completion: nil)
//        백_레이아웃()
    }

    
}

// 켈린더 sheet present modal
extension Mypage  {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if Calendar.current.isDateInToday(date) {
            calendar.appearance.titleSelectionColor = UIColor.black
        } else {
            calendar.appearance.titleSelectionColor = UIColor.white
        }

        handleSelectedDate(date)
    }
    
    private func handleSelectedDate(_ date: Date) {
        
        let 캘린더_스케쥴_등록_모달 = 캘린더_스케쥴_등록_모달()

        if let sheetPresent = 캘린더_스케쥴_등록_모달.presentationController as? UISheetPresentationController {
            sheetPresent.prefersGrabberVisible = true
            sheetPresent.detents = [.medium(), .large()]
            캘린더_스케쥴_등록_모달.isModalInPresentation = false
            sheetPresent.largestUndimmedDetentIdentifier = .large
            sheetPresent.prefersScrollingExpandsWhenScrolledToEdge = true
            sheetPresent.preferredCornerRadius = 30
            sheetPresent.prefersGrabberVisible = false
        }

        캘린더_스케쥴_등록_모달.modalPresentationStyle = .pageSheet
        self.present(캘린더_스케쥴_등록_모달, animated: true, completion: nil)
    }
}




extension Mypage {
    
    var 유저_다녀옴_날짜: [Date] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        return 특정날짜.map { dateFormatter.date(from: $0.date) }.compactMap { $0 }
    }
    
    
    func getCurrentUserUID() -> String? {
        guard let 현제유저 = Auth.auth().currentUser else {
            return nil
        }
        return 현제유저.uid
    }
    
    func 특정날짜방문_캘린더_적용() {
        guard let uid = getCurrentUserUID() else {
            print("User not authenticated")
            return
        }
        
        let 파이어스토어 = Firestore.firestore()
        let posters_메인컬렉션 = 파이어스토어.collection("posters")
        
        posters_메인컬렉션.addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self, let 메인_문서들 = querySnapshot?.documents, error == nil else {
                return
            }
            
            self.특정날짜 = []
            
            for 메인_문서 in 메인_문서들 {
                self.달력_방문날짜_포스터_업데이트(uid: uid, document: 메인_문서)
            }
            
            self.캘린더.reloadData()
        }
    }
    
    func 달력_방문날짜_포스터_업데이트(uid: String, document: QueryDocumentSnapshot) {
        let reviews_서브컬렉션 = document.reference.collection("reviews")
        
        reviews_서브컬렉션.addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self, let 서브_문서들 = querySnapshot?.documents, error == nil else {
                return
            }
            
            for 서브_문서 in 서브_문서들 {
                if let 다녀온_날짜 = 서브_문서["유저_다녀옴_날짜"] as? String {
                    if uid == 서브_문서.documentID {
                        self.달력_방문날짜_포스터_업데이트_배열(documentID: document.documentID, imageURL: 다녀온_날짜)
                        self.캘린더.reloadData()
                        
                    } else {
                    }
                }
            }
        }
    }
    
    func 달력_방문날짜_포스터_업데이트_배열(documentID: String, imageURL: String) {
        let 스토리지 = Storage.storage()
        let 스토리지참조 = 스토리지.reference().child("images")
        
        let 이미지파일명 = "\(documentID).png"
        let 이미지파일참조 = 스토리지참조.child(이미지파일명)
        
        이미지파일참조.downloadURL { [weak self] (url, 에러) in
            if let 에러 = 에러 {
                return
            }
            
            if let 다운로드된URL = url {
                let 특정날짜 = (date: imageURL, imageURL: 다운로드된URL.absoluteString)
                self?.특정날짜.append(특정날짜)
                
                self?.캘린더.reloadData()
            }
        }
    }
    
}

extension Mypage {
    func 포스터이미지URL업데이트_파이어스토어() {
        let 스토리지 = Storage.storage()
        let 스토리지참조 = 스토리지.reference().child("images")
        
        let 파이어스토어 = Firestore.firestore()
        let 포스터컬렉션 = 파이어스토어.collection("posters")
        
        포스터컬렉션.getDocuments { (쿼리스냅샷, 에러) in
            guard let 문서들 = 쿼리스냅샷?.documents, 에러 == nil else {
//                print("문서 가져오기 오류: \(에러?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            
            for 문서 in 문서들 {
                let 포스터ID = 문서.documentID
                let 리뷰컬렉션 = 포스터컬렉션.document(포스터ID).collection("reviews")
                
                let 이미지파일명 = "\(포스터ID).png"
                let 이미지파일참조 = 스토리지참조.child(이미지파일명)
                
                이미지파일참조.getMetadata { (metadata, error) in
                    if let error = error as NSError? {
                        if error.domain == StorageErrorDomain, let errorCode = StorageErrorCode(rawValue: error.code), errorCode == .objectNotFound {
                            return
                        }
                        return
                    }

                    이미지파일참조.downloadURL { (url, 에러) in
                        if let 에러 = 에러 {
                            return
                        }
                        
                        if let 다운로드된URL = url {
                            self.리뷰서브컬렉션내포스터이미지URL업데이트(리뷰컬렉션: 리뷰컬렉션, 이미지URL: 다운로드된URL.absoluteString)
                        }
                    }
                }
            }
        }
    }



    
    func 리뷰서브컬렉션내포스터이미지URL업데이트(리뷰컬렉션: CollectionReference, 이미지URL: String) {
        리뷰컬렉션.getDocuments { (쿼리스냅샷, 에러) in
            guard let 문서들 = 쿼리스냅샷?.documents, 에러 == nil else {
                return
            }
            
            for 문서 in 문서들 {
                let 업데이트데이터 = ["포스터이미지": 이미지URL]
                리뷰컬렉션.document(문서.documentID).setData(업데이트데이터, merge: true)
            }
        }
    }
    
}
