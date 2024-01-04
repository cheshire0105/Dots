import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

extension 캘린더_스케쥴_등록_모달 {
    func 데이터가져오기및UI업데이트() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("유저가 접속 상태가 아님")
            return
        }

        let 데이터베이스 = Firestore.firestore()

        데이터베이스.collection("posters").addSnapshotListener { [weak self] (포스터스쿼리스냅샷, 포스터스에러) in
            guard let self = self else { return }

            if let 포스터스에러 = 포스터스에러 {
                print("포스터스 문서 가져오기 에러: \(포스터스에러.localizedDescription)")
                return
            }

            guard let 포스터스문서들 = 포스터스쿼리스냅샷?.documents else {
                print("포스터스 문서가 없습니다.")
                return
            }

            self.셀_데이터_배열.셀_데이터_배열.removeAll()

            for 포스터스문서 in 포스터스문서들 {
                let 포스터스문서ID = 포스터스문서.documentID

                데이터베이스.collection("posters").document(포스터스문서ID).collection("reviews").document(uid).addSnapshotListener { [weak self] (리뷰문서스냅샷, 리뷰에러) in
                    guard let self = self else { return }

                    if let 리뷰에러 = 리뷰에러 {
                        print("리뷰 문서 가져오기 에러: \(리뷰에러.localizedDescription)")
                        return
                    }

                    guard let 리뷰문서데이터 = 리뷰문서스냅샷?.data(),
                          let 포스터이미지URL = 리뷰문서데이터["포스터이미지"] as? String,
                          let 방문날짜 = 리뷰문서데이터["유저_다녀옴_날짜"] as? String else {
                        return
                    }

                    let 리뷰문서ID = 리뷰문서스냅샷?.documentID ?? ""

                    데이터베이스.collection("전시_상세").document(포스터스문서ID).addSnapshotListener { [weak self] (전시상세스냅샷, 전시에러) in
                        guard let self = self else { return }

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
                            if let 이미지 = 이미지 {
                                let 데이터 = 셀_데이터(
                                    포스터이미지URL: 포스터이미지URL,
                                    전시명: 전시명,
                                    장소: 전시장소,
                                    방문날짜: 방문날짜,
                                    리뷰문서ID: 리뷰문서ID,
                                    포스터스문서ID: 포스터스문서ID
                                )

                                self.셀_데이터_배열.셀_데이터_배열.append(데이터)
                                 self.캘린더_전시_테이블뷰.reloadData()
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
}
