import UIKit
import FSCalendar
import SnapKit

extension Mypage: FSCalendarDelegate, FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
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

    private func hasEvent(for 날짜: Date) -> Bool {
        let 이벤트_날짜들 = [
            Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 26)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 27)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 2)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 3)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 5)),
            Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 31))
        ].compactMap { $0 }

        return 이벤트_날짜들.contains { Calendar.current.isDate(날짜, inSameDayAs: $0) }
    }

    func calendar(_ calendar: FSCalendar, imageFor 날짜: Date) -> UIImage? {
        if hasEvent(for: 날짜) {
            
        }

        return nil
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)

        if position == .current, let cell = cell as? FSCalendarCell, hasEvent(for: date) {
            // 기존 이미지 뷰를 제거
            cell.subviews.forEach { $0.removeFromSuperview() }

            // 이미지 셀 생성 및 설정
            let 이미지_셀 = UIButton(type: .custom)
            이미지_셀.setImage(UIImage(named: "help"), for: .normal)
            이미지_셀.layer.borderWidth = 1
            이미지_셀.layer.borderColor = UIColor(named: "neon")?.cgColor
            이미지_셀.clipsToBounds = true
            이미지_셀.layer.masksToBounds = true
            이미지_셀.layer.cornerRadius = 20

            let 이미지_크기 = CGSize(width: cell.frame.width, height: cell.frame.height)

            // 이미지를 셀 중앙에 위치시키기
            cell.addSubview(이미지_셀)
            이미지_셀.snp.makeConstraints { make in
                make.centerX.equalTo(cell.snp.centerX)
                make.centerY.equalTo(cell.snp.centerY).offset(-5)
                make.size.equalTo(40)
            }
        }

        return cell
    }
}

