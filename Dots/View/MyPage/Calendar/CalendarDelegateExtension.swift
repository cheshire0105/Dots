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

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        let postersCollection = db.collection("posters")

        postersCollection.document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let documentData = document.data()
                
                if let reviewCollection = documentData?["review"] as? [[String: Any]] {
                    for reviewDocument in reviewCollection {
                        if let date = reviewDocument["유저_다녀옴_날짜"] as? Timestamp {
                            let formattedDate = date.dateValue()
                            self.유저_다녀옴_날짜.append(formattedDate)
                        }
                    }
                }
            } else {
            }
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


