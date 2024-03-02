### 2024-03-02 백상희 
-  user_insert_form.jsp | name="user_gender" => name="user_grade" 수정

### 2024-02-20 최시환 PM 07:30
자바파일 : BoardController, UserController BoardDao board.xml 수정하였습니다
webapp 파일 : 어드민폴더 admin_page.jsp, 보드폴더 board_list.jsp, user폴더 mypage_main.jsp 변경하였으며 user폴더에 my_page_board_view.jsp 추가 하였습니다

그리고 index.jsp 로그인쪽 if문 변경되었습니다 
디자인쪽 현재까지 올리신 index.jsp파일이랑 비교해가면서 수정하였는데 잘못 수정한 부분이 있을수도 있어서 확인 부탁드립니다


### 2024-02-29 최병훈 PM 06:00 
index.jsp, header.jsp, footer.jsp<br>
./css/style.css<br>
./img/main_intro.png<br>
Update

### 2024-02-29 이영준 PM 02:20
- 운동정보 모든 파일(vo, dao, util, controller, jsp) 업데이트

### 2024-02-29 최병훈 AM 10:30 
index.jsp, header.jsp, footer.jsp<br>
./user/user_login_form.jsp<br>
./user/user_insert_form.jsp<br>
./css/style.css<br>
./img/intro.png, login_title.png<br>
Update

### 2024-02-28 최병훈
index.jsp, header.jsp, footer.jsp
./css/style.css
Update

## 2024-02-28 이영준 
- 운동 정보 파일 추가 (vo, dao, util, controller(mapper추가, web.xml에 controller 추가, jsp)
- workout_kcal table에 user_name (String) 추가해야 합니다.

## 2024-02-27 최시환
- admin폴더 경로 변경하였습니다

## 2024-02-27 최시환
- 로그인폼에서 회원가입 누를 시 메인화면으로 이동돼서 경로 수정하였습니다

## 2024-02-27 최시환
- user폴더에 user_list.jsp 삭제, UserController 경로변경, board 로그인기능 제거, admin폴더 생성+ admin.xml&Controller추가

## 2024-02-27 백상희
- 음식 칼로리 계산 기능 파일 추가 (FoodVo, MealTypeVo, FoodController, FoodSearchUtils, Mapper, jsp)
- src/main/webapp index.jsp 파일 업로드 및 index.html 수정

## 2024-02-27 이영준
- 메인페이지(wepapp - index.html) 추가 (제컴에선 회원가입 등등 링크가 동작이 안되는데 주소는 잘 넘어가서 각자 컴에선 되시는지 확인 부탁드려요)

## 2024-02-26 최시환
- Board 검색기능, 카테고리기능 추가하였습니다

## 2024-02-26 최시환
- Comment기능(Dao,Vo,Controller,Comment.xml,Comment.jsp폴더) 추가하였습니다

## 2024-02-23 최시환
- BoardController,board.xml.board_list.jsp,board_view.jsp 변경하였으며 board_reply삭제하였습니다

## 2024-02-23 이영준
- weather 업로드 (vo, Controller, Utils, jsp(main, list), web.xml에 controller 추가)

## 2024-02-22 최시환
- user DB 회원가입,로그인 업로드

## 2024-02-22 백상희
- Database schema 업로드
- Database sql 업로드
  (기존의 mysql database 사용할 경우, 수업때 사용한 테이블명이 중복된 테이블은 삭제해야합니다.
  그 부분이 싫으시면 다른 데이터베이스를 생성하시고 진행하시면 됩니다.)
