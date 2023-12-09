import UIKit
import FSCalendar
import SnapKit

extension Mypage: FSCalendarDelegate, FSCalendarDataSource {
    var specificDates: [Date] {
        [
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 8)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 9)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 12))
        ].compactMap { $0 }
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }

 

    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if specificDates.contains { Calendar.current.isDate(date, inSameDayAs: $0) } {
            return nil // 이미지를 직접 추가할 것이므로 nil 반환
        }

        return nil
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)

        if position == .current, let cell = cell as? FSCalendarCell, specificDates.contains { Calendar.current.isDate(date, inSameDayAs: $0) } {
            // 이미지 셀이 존재하지 않을 때에만 추가
            if cell.subviews.filter({ $0 is UIButton }).isEmpty {
                let imageCell = UIButton(type: .custom)
                imageCell.setImage(UIImage(named: "help"), for: .normal)
                imageCell.layer.borderWidth = 1
                imageCell.layer.borderColor = UIColor(named: "neon")?.cgColor
                imageCell.clipsToBounds = true
                imageCell.layer.masksToBounds = true
                imageCell.layer.cornerRadius = 20
                imageCell.isUserInteractionEnabled = false

                let imageSize = CGSize(width: cell.frame.width, height: cell.frame.height)

                // 이미지를 셀 중앙에 위치시키기
                cell.addSubview(imageCell)
                imageCell.snp.makeConstraints { make in
                    make.centerX.equalTo(cell.snp.centerX)
                    make.centerY.equalTo(cell.snp.centerY).offset(-5)
                    make.size.equalTo(40)
                }
            }
        }

        return cell
    }
}















//켈린더 sheetpresent modal

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

