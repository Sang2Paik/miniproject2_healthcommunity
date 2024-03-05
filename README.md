# 미니프로젝트 - 헬스케어 커뮤니티 서비스

https://github.com/Sang2Paik/miniproject2_healthcommunity/assets/147046089/17149eb5-855a-4db0-bed2-3319dcc175a9

<hr>

# :clipboard: 목차
### 1. [프로젝트 설명](#movie_camera-프로젝트-설명)
### 2. [개발 기간](#calendar-개발-기간)
### 3. [팀원소개](#family-팀원소개)
### 4. [사용기술](#wrench-사용기술)
### 5. [개선해야할 점](#cry-개선해야할-점)

<hr>

 # :movie_camera: 프로젝트 설명

 1. 기능 개요
  - 회원가입 및 로그인 기능이 제공됩니다.
  - 위치 정보 기반으로 실시간 날씨 정보 제공
  - 운동, 식단에 대한 게시판
  - 마이페이지에서 일일 활동량, 일일 섭취량에 대한 정보 관리
 2. 기능 상세 설명
  - 회원가입 및 로그인: 사용자는 회원가입을 통해 서비스를 이용할 수 있고, 로그인하여 개인 정보를 관리할 수 있습니다.
  - 위치 정보에 따라 실시간 날씨를 확인할 수 있고, 야외 활동 또는 실내 활동을 추천해줍니다.
  - 가입 유저는 운동, 식단에 대한 인증 게시글을 등록할 수 있고, 등록된 게시물에 대해서 댓글을 달 수 있습니다.
  - 게시글은 공개/비공개 선택이 가능하며, 비공개한 게시글은 나의 페이지에서 볼 수 있습니다.
  - 나의 페이지에서는 나의 건강정보(키와 몸무게, BMI, 기초대사량 등), 나의 기본정보, 나의 게시글을 볼 수 있습니다.
  - 일일 활동, 일일 식사를 등록할 수 있고, 칼로리를 계산하여 나의 정보를 관리할 수 있습니다.

  ## <a href="https://github.com/Sang2Paik/miniproject2_healthcommunity/tree/main">Source Repository</a>

<hr>

# :calendar: 개발 기간
- ` 2024년 2월 22일 (목) ~ 2024년 3월 4일(월) `
- ` 설계 1일 / 개발 6일 `

<hr>

# :family: 팀원소개
  
  ## WEB DESIGN  
  ## BACK END 
  * 백상희
    * DB 설계 
    * 공공 API를 활용한 식단에 대한 정보 CRUD 기능 구현 및 페이지 디자인
  * 이영준
    * 날씨 API를 활용한 위치정보 기반 날씨정보 출력
    * 공공 API를 활용한 운동에 대한 정보 CRUD 기능 구현 및 페이지 디자인
  * 최시환
    * 로그인, 로그아웃, 회원가입 기능 구현
    * 게시판 정보 CRUD 기능 구현 및 페이지 디자인
    * 댓글, 좋아요, 조회수에 대한 기능 구현
    * 회원 정보 관리에 대한 어드민 페이지 기능 구현 및 페이지 디자인

<hr>

# :wrench: 사용기술

  #### Front-End 
  <div style="display:inline-block">
    <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=HTML5&logoColor=white" />
    <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=CSS3&logoColor=white" />
    <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=JavaScript&logoColor=white" />
    <img src="https://img.shields.io/badge/Bootstrap-7952B3?style=flat&logo=bootstrap&logoColor=white" /> 
  </div>
  
  #### Back-End
  <div style="display:inline-block">
    <img src="https://img.shields.io/badge/Java-007396?style=flat&logo=Java&logoColor=white" /> 
    <img src="https://img.shields.io/badge/Apache Tomcat-F8DC75?style=flat&logo=apachetomcat&logoColor=white" /> 
    <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white" />  
    <img src="https://img.shields.io/badge/MyBatis-red"/>
  </div>
  
  #### Tools
  <div style="display:inline-block">
    <img src="https://img.shields.io/badge/Elipse-2C2255?style=flat&logo=eclipseide&logoColor=white" /> 
  </div>

<hr>

# :cry: 개선해야할 점

1. 음식을 등록할 때, 공공 API를 활용했는데 공공 API 검색어에서는 같은 음식명에 성분이 약간 다른 것이 중복된 것이 많아서 가독성이 떨어졌다.
   그리고 사용자에게 친근한 단어로 찾는 것도 힘든 것이 많았다. 그래서 검색을 했을때 나오지 않는 경우에는 직접 등록하는 것도 구현해야하지 않았나하는 아쉬움이 있다.
2. 음식이나 운동에 대한 정보를 등록하면 그래프로 보여주는 부분은 데이터가 들어가야만 그래프로 나와, 입력하지 않은 날은 데이터가 없다.
   이 부분도 0kcal로 등록을 해줘야하지 않을까하는 아쉬움이 있다. 
