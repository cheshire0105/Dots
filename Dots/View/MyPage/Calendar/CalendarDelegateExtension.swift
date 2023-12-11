import UIKit
import FSCalendar
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

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

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at 특정_날짜셀에_이미지_넣기: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: 특정_날짜셀에_이미지_넣기)

        if 특정_날짜셀에_이미지_넣기 == .current, let cell = cell as? FSCalendarCell, 유저_다녀옴_날짜.contains(where: { Calendar.current.isDate(date, inSameDayAs: $0) }) {


            if cell.subviews.filter({ $0 is UIButton }).isEmpty {
                let 날짜에_등록할_이미지 = UIButton(type: .custom)
                날짜에_등록할_이미지.setImage(UIImage(named: "help"), for: .normal)
                날짜에_등록할_이미지.layer.borderWidth = 1
                날짜에_등록할_이미지.layer.borderColor = UIColor(named: "neon")?.cgColor
                날짜에_등록할_이미지.clipsToBounds = true
                날짜에_등록할_이미지.layer.masksToBounds = true
                날짜에_등록할_이미지.layer.cornerRadius = 20
                날짜에_등록할_이미지.isUserInteractionEnabled = false

                cell.addSubview(날짜에_등록할_이미지)
                날짜에_등록할_이미지.snp.makeConstraints { make in
                    make.centerX.equalTo(cell.snp.centerX)
                    make.centerY.equalTo(cell.snp.centerY).offset(-5)
                    make.size.equalTo(40)
                }
            }
        } else {
            cell.subviews.filter { $0 is UIButton }.forEach { $0.removeFromSuperview() }
        }

        return cell
    }
}

// 켈린더 sheet present modal
extension Mypage {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if Calendar.current.isDateInToday(date) {
            calendar.appearance.titleSelectionColor = UIColor(named: "neon")
        } else {
            calendar.appearance.titleSelectionColor = UIColor.white
        }


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
             let dateStrings = 특정날짜
 
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd"
             dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
 
             return dateStrings.compactMap { dateFormatter.date(from: $0) }
         }
     func getCurrentUserUID() -> String? {
        guard let 현제유저 = Auth.auth().currentUser else {
            return nil
        }
        return 현제유저.uid
    }

     func fetchUserVisitedDates() {
        guard let uid = getCurrentUserUID() else {
            print("User not authenticated")
            return
        }

        let 파이어스토어 = Firestore.firestore()
        let posters_메인컬렉션 = 파이어스토어.collection("posters")

        posters_메인컬렉션.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self, let 메인_문서들 = querySnapshot?.documents, error == nil else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            for 메인_문서 in 메인_문서들 {
                self.fetchUserVisitDateFromReviews(uid: uid, document: 메인_문서)
            }
        }
    }

     func fetchUserVisitDateFromReviews(uid: String, document: QueryDocumentSnapshot) {
        let reviews_서브컬렉션 = document.reference.collection("reviews")

        reviews_서브컬렉션.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self, let 서브_문서들 = querySnapshot?.documents, error == nil else {
                print("문서 불러오기 오류: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            for 서브_문서 in 서브_문서들 {
//                print("리뷰 UID: \(서브_문서.documentID)")

                if let 다녀온_날짜 = 서브_문서["유저_다녀옴_날짜"] as? String {
//                    print("리뷰 UID: \(서브_문서.documentID), 유저 UID: \(uid), 다녀온 날짜: \(다녀온_날짜)")

                    if uid == 서브_문서.documentID {
                        self.특정날짜.append(다녀온_날짜)
                    } else {
//                        print("리뷰 UID and 유저 UID 일치하지않음 데이터 처리 않함.")
                    }
                }
            }
            self.캘린더.reloadData()
            
        }
    }

}
