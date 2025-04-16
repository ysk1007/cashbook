# 💰 Cashbook

가계부 웹 애플리케이션 프로젝트입니다. 사용자는 수입 및 지출 내역을 등록하고, 월별 및 카테고리별 통계를 확인할 수 있습니다.

## 📌 주요 기능

- 수입/지출 내역 등록, 수정, 삭제
- 영수증 이미지 첨부 및 삭제 기능
- 날짜별, 월별, 카테고리별 통계 제공
- 페이징 및 검색 기능 지원 (카테고리)
- SB Admin 2 템플릿 기반 UI 구성

## 📷 미리보기

| 가계부 달력 화면 | 통계 차트 | 일별 수입/지출 |
|---|---|---|
| ![Image](https://github.com/user-attachments/assets/e953e0cf-1d1d-428b-a2aa-4a726383f877) | ![Image](https://github.com/user-attachments/assets/ffb49583-921a-4d8a-a40a-3f22e45aa80a) | ![Image](https://github.com/user-attachments/assets/613627b6-17d5-45b0-98c1-795650c510b8) |

---

## 🛠 기술 스택

- `Java` (JDK 11 이상)
- `JSP & Servlet`
- `JSTL`
- `MySQL`
- `Apache Tomcat`
- `Bootstrap` (SB Admin 2)
- `JavaScript`, `jQuery`
- `Chart.js`

## 📁 프로젝트 구조

```
cashbook/
├── src/
│   └── controller/       # 서블릿 컨트롤러
│   └── dao/              # DB 접근 로직
│   └── vo/               # VO 클래스
├── WebContent/
│   └── css/              # 사용자 정의 CSS
│   └── js/               # 사용자 정의 JS
│   └── img/              # 이미지 파일
│   └── view/             # JSP 뷰
│   └── META-INF/
│   └── WEB-INF/
├── README.md
└── .gitignore
```

## ⚙️ 실행 방법

1. 프로젝트를 Eclipse 또는 IntelliJ로 import합니다.
2. MySQL에 데이터베이스 및 테이블을 생성합니다.
3. `db.properties` 또는 `context.xml`에 DB 정보를 설정합니다.
4. Tomcat 서버를 실행하고 웹 브라우저로 접속합니다.
   - 기본 URL: `http://localhost:8080/cashbook`

## 🤝 기여 & 이슈
- 버그나 제안이 있다면 [Issues](https://github.com/ysk1007/poll/issues)를 통해 남겨주세요.
- 누구든지 Fork & PR 환영합니다!
  

## 👨‍💻 개발자
**윤성권 (Yun Sungkwon)**  
📫 [GitHub](https://github.com/ysk1007)
