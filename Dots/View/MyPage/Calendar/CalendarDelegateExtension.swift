import UIKit
import FSCalendar
import SnapKit

extension Mypage : FSCalendarDelegate, FSCalendarDataSource {
    
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
    
    private func isEventScheduled(for date: Date) -> Bool {
        return true
    }
    private func 날짜에_들어갈_이미지_동그란모양(_ 이미지: UIImage, 사이즈: CGSize) -> UIImage {
        let 날짜에_들어갈_이미지 = UIButton(type: .custom)
        날짜에_들어갈_이미지.setImage(이미지, for: .normal)
        
        var 최종_이미지_크기 = 사이즈
        
        if 사이즈.width > 사이즈.height {
            최종_이미지_크기.width = 사이즈.height
        } else if 사이즈.height > 사이즈.width {
            최종_이미지_크기.height = 사이즈.width
        }
        
        날짜에_들어갈_이미지.frame = CGRect(origin: .zero, size: 최종_이미지_크기)
        날짜에_들어갈_이미지.contentMode = .scaleAspectFill
        날짜에_들어갈_이미지.layer.cornerRadius = 최종_이미지_크기.height / 2
        날짜에_들어갈_이미지.layer.masksToBounds = true
        날짜에_들어갈_이미지.layer.borderWidth = 1.5
        날짜에_들어갈_이미지.layer.borderColor = UIColor(named: "neon")?.cgColor
        날짜에_들어갈_이미지.contentHorizontalAlignment = .center
        
        UIGraphicsBeginImageContextWithOptions(최종_이미지_크기, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        날짜에_들어갈_이미지.layer.render(in: context)
        
        if let 이미지_위치 = UIGraphicsGetImageFromCurrentImageContext() {
            return 이미지_위치
        }
        
        return UIImage()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor 날짜: Date) -> UIImage? {
        if hasEvent(for: 날짜) {
            //            let 셀_프레임 = calendar.frame(for: 날짜)
            //            let 이미지_크기 = CGSize(width: 셀_프레임.width, height: 셀_프레임.height)
            //
            //            if let 날짜에_등록될_이미지 = UIImage(named: "help") {
            //                let 이미지_사이즈_재정의 =  날짜에_들어갈_이미지_동그란모양(날짜에_등록될_이미지, 사이즈: 이미지_크기)
            //
            //                // 이미지를 셀 중앙에 위치시키기
            //                let 이미지_프레임 = CGRect(
            //                    x: (셀_프레임.width - 이미지_크기.width) / 2,
            //                    y: (셀_프레임.height - 이미지_크기.height) / 2 - 10, // centerY를 위로 10 옮김
            //                    width: 이미지_크기.width,
            //                    height: 이미지_크기.height
            //                )
            //
            //                let 이미지_중앙 = UIButton(frame: 이미지_프레임)
            //                이미지_중앙.setImage(이미지_사이즈_재정의, for: .normal)
            //                return 이미지_중앙.imageView?.image
            //            }
        }
        
        return nil
    }
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        
        if position == .current, let cell = cell as? FSCalendarCell, hasEvent(for: date) {
            // 이미지 셀 생성 및 설정
            let 이미지_셀 = UIButton(type: .custom)
            이미지_셀.setImage(UIImage(named: "help"), for: .normal)
            이미지_셀.layer.borderWidth = 1
            이미지_셀.layer.borderColor = UIColor(named: "neon")?.cgColor
            이미지_셀.clipsToBounds = true
            이미지_셀.layer.masksToBounds = true
            이미지_셀.layer.cornerRadius = 20

            let 이미지_크기 = CGSize(width: cell.frame.width, height: cell.frame.height)
            let 이미지_사이즈_재정의 = 날짜에_들어갈_이미지_동그란모양(UIImage(named: "help")!, 사이즈: 이미지_크기)
            
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
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        // 날짜 셀들의 간격을 조절하는 부분
//        calendar.snp.updateConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: -10, left: 10, bottom: 10, right: 10))
//        }
//    }
}
    

