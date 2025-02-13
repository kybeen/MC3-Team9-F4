# MC3-Team9-F4


<br>

<br>

<div align="center">
<img width = "100" src="https://github.com/user-attachments/assets/372ce78f-da84-4e09-bd43-a7030a612d40">

# Tering(테링)
</div>

<div align="center">
<img width="250" src="https://github.com/user-attachments/assets/df119e6b-b62b-48d6-b8bb-5a7c721a876e"> <img width="250" src="https://github.com/user-attachments/assets/30b22dd8-0cbb-4e24-b831-ce0f306fdd62">
<!-- <img width="393" height="852" src="https://github.com/DeveloperAcademy-POSTECH/MC3-Team9-F4/assets/89764127/c82c0121-69fb-4373-b3d8-6ace2b23c992"> -->

<br>

<br>

[<img width = "200" src="https://github-production-user-asset-6210df.s3.amazonaws.com/120548537/251533420-0eb9b31b-8203-48b7-8dcd-3725a8c9da49.png">](https://apps.apple.com/kr/app/tering/id6464368312)
  
</div>

<br>

## 📑 Description

#### 📆 2023. 06. 19. ~ 2023. 08. 04. (7 weeks)

### 테링은 테린이들의 테니스 자세 연습을 도와주는 앱입니다. 🎾

반복되는 자세 연습에 지친 테니스 초심자들이 애플워치를 통해 즉각적으로 피드백을 받으면서 재밌게 연습을 할 수 있도록 앱을 만들게 되었습니다.
  

### ✅ Core Motion, CoreML 을 활용한 스윙 동작 감지 및 분류
  - 테니스 연습을 시작하면 Core Motion 프레임워크를 통해 애플워치에서 센서값을 추적합니다.
  - 센서값을 통해 스윙이 감지되면 Create ML을 통해 학습시킨 Activity Classifier 모델이 스윙 동작을 분류합니다.
  - 모델의 예측 결과에 따라 어떤 자세인지(포핸드/백핸드)와 자세의 정확도에 따른 평가(Perfect/Bad)를 보여줍니다.

### ✅ HealthKit을 활용한 백그라운드 동작 & 햅틱을 통한 피드백
  - HealthKit의 HKWorkoutSession을 활용해서 애플워치가 잠듦 상태에 들어가도 테링은 계속 유저의 동작을 추적합니다.
  - 테니스 연습 중에 소모한 칼로리, 심박수, 운동 시간을 체크해줍니다.
  - 테니스 스윙이 감지되어 모델 분류가 수행되면 햅팁을 통해 유저에게 피드백을 알려줍니다.

### ✅ Watch Connectivity를 활용한 데이터 전송
  - watchOS App에서 수집된 테니스 데이터는 Watch Connectivity 프레임워크를 통해 페어링된 iOS App으로 전송됩니다.

<br>



## 🔍 Preview

|(iOS) 오늘의 스윙 기록 확인| (iOS) 이전 스윙 데이터 확인|
|:---:|:---:|
|<img width="80%" src="https://github.com/user-attachments/assets/fe0ee3ad-c613-4106-ad63-44158dec23a1"/>|<img width="80%" src="https://github.com/user-attachments/assets/d72868d9-d9f8-43ea-9539-ece3e15dd71b"/>|

| (watchOS) 목표 스윙 개수 설정 | (watchOS) 테니스 연습 시작 | (watchOS) 스윙 감지 및 동작 분류 |
|:---:|:---:|:---:|
|<img width="80%" src="https://github.com/user-attachments/assets/8dfb4104-ca63-48c8-977a-a43ac2eefe0f"/>|<img width="80%" src="https://github.com/user-attachments/assets/7635d642-67c4-4900-aeb5-56c58f568ed6"/>|<img width="80%" src="https://github.com/user-attachments/assets/e455e919-89c4-4988-8038-bdc73c10069c"/>|

| (watchOS) 스윙 분류 결과 확인 | (watchOS) 테니스 연습 결과 확인 | (watchOS) 운동 데이터 확인 |
|:---:|:---:|:---:|
|<img width="80%" src="https://github.com/user-attachments/assets/ab43b71e-6e55-436b-9954-2ee4d63a33b4"/>|<img width="80%" src="https://github.com/user-attachments/assets/223f0f96-f83c-4fee-84eb-823d38f02e4f"/>|<img width="80%" src="https://github.com/user-attachments/assets/2d52c2d4-03a2-4364-a80e-efaa745fdaca"/>|

<br>



<br>

## 💻 Development Environment

<img height="20" src="https://img.shields.io/badge/iOS-16.0+-lightgray">  <img height="20" src="https://img.shields.io/badge/Xcode-14.3-skyblue">  <img height="20" src="https://img.shields.io/badge/Swift-5.8.1-orange"> <img height="20" src="https://img.shields.io/badge/Platform-iOS | watchOS-lightgreen"> 

<br>

<br>

## 🔩 Tech & Skills

<img width="73" src="https://img.shields.io/badge/SwiftUI-blue"> <img width="86" src="https://img.shields.io/badge/WatchKit-blue"> <img width="95" src="https://img.shields.io/badge/HealthKit-blue"> <img width="170" src="https://img.shields.io/badge/Watch Connectivity-blue"> <img width="110" src="https://img.shields.io/badge/Core Motion-blue"> <img width="75" src="https://img.shields.io/badge/CoreML-blue"> <img width="95" src="https://img.shields.io/badge/Create ML-blue"> <img width="95" src="https://img.shields.io/badge/Combine-blue"> <br>

<br>

<br>
  
## 🛠️ Tools
**Design**  
  
<img height="23" src="https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=Figma&logoColor=white"/>  

**Cowork**  

<img height="23" src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white"/>  <img height="23" src="https://img.shields.io/badge/Notion-FFFFFF?style=flat-square&logo=Notion&logoColor=black"/>  <img height="23" src="https://img.shields.io/badge/Miro-F2CA02?style=flat-square&logo=Miro&logoColor=black"/>
<img height="23" src="https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=Figma&logoColor=white"/>  

<br>

<br>

<br>

## 📁 **폴더링**

- iOS
```
📦MC3_Tering
 ┣ 📂Model
 ┃ ┣ 📂CongreteModel
 ┃ ┣ 📂CoreData
 ┃ ┃ ┣ 📂UserData
 ┃ ┃ ┣ 📂UserInfo.xcdatamodeld
 ┃ ┃ ┣ 📂WorkOutData
 ┃ ┃ ┗ 📜CoreDataManager.swift
 ┃ ┣ 📜UserDataModel.swift
 ┃ ┣ 📜ViewModelPhone.swift
 ┃ ┗ 📜WorkOutDataModel.swift
 ┣ 📂Util
 ┃ ┗ 📜GifView.swift
 ┣ 📂View
 ┃ ┣ 📂AppGuideView
 ┃ ┣ 📂CongreteModalView
 ┃ ┣ 📂Extension
 ┃ ┣ 📂GuideView
 ┃ ┣ 📂MainView
 ┃ ┃ ┣ 📂ChartView
 ┃ ┃ ┣ 📂RecordListView
 ┃ ┃ ┣ 📜MainView.swift
 ┃ ┃ ┗ 📜RingChartsView.swift
 ┃ ┣ 📂OnboardingView
 ┃ ┣ 📂Resource
 ┃ ┃ ┣ 📂Font
 ┃ ┃ ┣ 📂Gif
 ┃ ┃ ┣ 📜CustomBackButton.swift
 ┃ ┃ ┗ 📜CustomSegmentedView.swift
 ┃ ┣ 📂SettingView
 ┃ ┣ 📂TodayDetailView
 ┃ ┣ 📜ContentView.swift
 ┃ ┗ 📜TestPhoneView.swift
 ┣ 📜CameraModel.swift
 ┣ 📜CameraView.swift
 ┣ 📜CameraViewModel.swift
 ┗ 📜MC3_TeringApp.swift
              
```

- watchOS
```
📦MC3_Tering_Watch Watch App
 ┣ 📂Extension
 ┃ ┣ 📜CircleProgressBar.swift
 ┃ ┣ 📜ColorExtension.swift
 ┃ ┗ 📜ElapsedTimeView.swift
 ┣ 📂MLModel
 ┃ ┣ 📜TennisClassifierViewModel.swift
 ┃ ┗ 📜TeringClassifier_totalData_window100.mlmodel
 ┣ 📂Model
 ┃ ┣ 📂Particle
 ┃ ┃ ┣ 📜Particle.swift
 ┃ ┃ ┗ 📜ParticleEffect.swift
 ┃ ┣ 📂Workout
 ┃ ┃ ┣ 📜SwingInfo.swift
 ┃ ┃ ┣ 📜WorkoutManager.swift
 ┃ ┃ ┗ 📜WorkoutResultInfo.swift
 ┃ ┗ 📜ViewModelWatch.swift
 ┣ 📂Preview Content
 ┃ ┗ 📂Preview Assets.xcassets
 ┃ ┃ ┗ 📜Contents.json
 ┣ 📂View
 ┃ ┣ 📂EtcView
 ┃ ┃ ┣ 📜CompleteView.swift
 ┃ ┃ ┗ 📜TestLayoutView.swift
 ┃ ┣ 📂ResultView
 ┃ ┃ ┗ 📜ResultView.swift
 ┃ ┣ 📂StartView
 ┃ ┃ ┣ 📜ReadyView.swift
 ┃ ┃ ┗ 📜SwingCountView.swift
 ┃ ┗ 📂WorkoutView
 ┃ ┃ ┣ 📂Complete
 ┃ ┃ ┃ ┣ 📜SelectView.swift
 ┃ ┃ ┃ ┗ 📜SwingCompleteView.swift
 ┃ ┃ ┣ 📂Measurement
 ┃ ┃ ┃ ┣ 📜MeasuringView.swift
 ┃ ┃ ┃ ┗ 📜SwingResultView.swift
 ┃ ┃ ┗ 📜CountingView.swift
 ┗ 📜MC3_Tering_WatchApp.swift
              
```

<br>

## **📝 커밋 컨벤션**
  
<details>
<summary>팀 협업용 깃허브 컨벤션 문서 </summary>
<div markdown="1">

<br>
 
## **Fork를 통한 협업**

### 원본(메인) 레포에서 브랜치를 생성하여 작업을 하는 것이 아니라

각자 레포를 fork한 후, 본인(포크한) 레포에서 작업을 한 이후
원본(메인)레포에 PR을 요청하는 방식으로 진행하는 방법입니다.

<img width="401" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/MC3-Team9-F4/assets/104834390/0e8ef132-e542-4b87-8b2b-112d2b382d4d">


- Fork를 통해  진행하는 이유
  - 원본 레포의 브랜치에서 작업을 하다보면 누군가가 작업을 하는 도중에 다른 사람이 작업을 진행하게 되면, conflict가 날 확률이 매우 높아지기 때문에,
    각자 작업을 한 뒤, 원본 레포에 merge를 진행하여 conflict를 방지하기 위해 진행합니다.

<!-- ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3e11e3d7-c9fb-4084-8ce6-751e7a71239a/Untitled.png) -->

1. 원본 레포를 fork하여 내 레포에 생성합니다.

2. 원하는 디렉토리에 git을 초기화 시켜줍니다.

```bash
git init
```

3. 원본(메인) 레포를 upstream으로 remote해줍니다.

```bash
git remote add upstream <원본(메인)레포 주소>
```

4. 로컬(나의) 레포를 origin으로 remote해줍니다.

```bash
git remote add origin <로컬(포크한 나의)레포 주소>
```

**작업을 진행할 시 upstream에서 pull을 받아오고, origin으로 push를 날려주어 pr을 진행합니다.**

→ 공동 작업물을 받아와서 내 개인 컴퓨터로 작업을 한 뒤, 공동 작업물에 합칠 수 있도록 진행하는 것

1. 이슈 템플릿에 맞춰 원본(메인) 레포에 이슈를 생성합니다.

    <!-- ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/80566569-4c1a-4944-a5b5-eb13a0ac4aeb/Untitled.png) -->

    - New issue를 클릭하여 이슈를 생성합니다.
    - **[Prefix] 작업 목표**
    ex) [Design] Weather View 디자인

2. 이슈를 만들면 이슈 제목에 이슈 번호가 생성되는데, (ex) ~/#7)
로컬에 feature/#이슈번호 브랜치를 생성합니다.

```bash
git branch feature/#7    //이슈번호7의 브랜치 생성
```

3. 해당 브랜치로 이동하여 작업을 합니다.

```bash
git switch feature/#7    //해당 브랜치로 변경
```

4. 작업이 끝난 뒤, add와 commit을 진행합니다.

```bash
git add .    //작업 요소를 더해줌
git commit -m "[Prefix] <앱 이름>#이슈번호 - Weather View 디자인 구현"    //무엇을 구현했는지 메세지로 작성
```

5. 내가 작업을 하는 도중에 다른 사람이 작업을 진행하여 원본(메인)레포가 변경되어 있을 수도 있으니,
(확인을 위해) pull을 한 번  진행해준다.

```bash
git pull upstream develop    //원본(메인)레포의 파일을 불러온다.
```

6. 에러가 나지 않았다면, origin에서 작업한 내용을 push해준다.

```bash
git push -u origin <브랜치명>    //해당 브랜치를 올리고자 한다.
```

7. PR을 통해 코드 리뷰를 진행한 뒤, approve를 해준다면 merge를 한다.

8. 기본 브랜치로 돌아옵니다.

```bash
git switch develop(main)
```

9. 1번부터 다시 진행을 하며 작업을 반복하면 됩니다.

<br>
<br>

## Git Branch Convention

- 브랜치를 생성하기 전에, 이슈를 작성해야 하는데,
**[브랜치 종류]/#<이슈번호>**의 양식에 따라 브랜치 명을 작성합니다.

- 브랜치 종류
  - develop : feature 브랜치에서 구현된 기능들이 merge될 브랜치. default 브랜치입니다.
  - **feature** : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발합니다.
    주로 많이 사용합니다.
  - main : 개발이 완료된 산출물이 저장될 공간
  - release : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
  - bug : 버그를 수정하는 브랜치
  - hotfix : 정말 급하게, 제출 직전에 에러가 난 경우 사용하는 브렌치

ex) feature/#6

<br>
<br>

## Commit Convention

- commit은 최대한 자세히 나누어서 진행해야 하기 때문에, 하나의 이슈 안에서도 매우 많은 commit이 생성될 수 있습니다.
**[prefix] (해당 앱 이름(옵션))#이슈번호 - 이슈 내용**의 양식에 따라 커밋을 작성합니다.

- prefix 종류
  - [Feat]: 새로운 기능 구현
  - [Setting]: 기초 세팅 관련
  - [Design]: just 화면. 레이아웃 조정
  - [Fix]: 버그, 오류 해결, 코드 수정
  - [Add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
  - [Del]: 쓸모없는 코드, 주석 삭제
  - [Refactor]: 전면 수정이 있을 때 사용합니다
  - [Remove]: 파일 삭제
  - [Chore]: 그 이외의 잡일/ 버전 코드 수정, 패키지 구조 변경, 파일 이동, 파일이름 변경
  - [Docs]: README나 WIKI 등의 문서 개정
  - [Comment]: 필요한 주석 추가 및 변경

ex) [Design] DreamLog#4 - 응원 뷰 레이아웃 디자인

<br>
<br>

## Issue

### 이슈 생성 시

- [Prefix] 뷰이름 이슈명
ex) [Design] MyView - MyView 레이아웃 디자인
- 우측 상단 Assignees 자기 자신 선택 → 작업 할당된 사람을 선택하는 것
- Labels Prefix와 자기 자신 선택

<br>

## PR

### PR 요청 시

- Reviewers 자신 제외 모두 체크
- Assignees 자기 자신 추가
- Labels 이슈와 동일하게 추가
- 서로 코드리뷰 꼭 하기
- 수정 필요 시 수정하기

<br>

## 📁폴더링 -> 수정 예정

**mc2-DreamLog**  

**mc2-DreamLog**

- **Global**
  - **Modifier**
  - **Components**
  - **Extension**
- **Resources**
  - **Assets**
  - **Fonts**
- **Model**
- **View**
  - **Tutorial**

</div>
</details>
  
  <br>
  
   [![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FDeveloperAcademy-POSTECH%2FMC2-morning-Team12-DreamLog&count_bg=%2326980A&title_bg=%23FFFBF6&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)


<br>
<br>

## **👨‍👨‍👧 Member**  

|Bazzi|Dana|Rei|Ted|
|:---:|:---:|:---:|:---:|
|<img alt="" src="https://github.com/user-attachments/assets/b598a3ef-df85-467d-afe8-694c2ddc4ef4" width="150">|<img alt="" src="https://github.com/user-attachments/assets/e7af9d3f-bd34-413e-806d-8be6815915ce" width="150">|<img alt="" src="https://github.com/user-attachments/assets/f2d4a8d9-3406-426d-9368-08f853a00db9" width="150">|<img alt="" src="https://github.com/user-attachments/assets/74297560-3450-4c69-8489-58a139dd7db7" width="150">
|[<img src="https://img.shields.io/badge/Github-black?style=for-the-badge&logo=github&logoColor=white" alt="Github Blog Badge"/>](https://github.com/DhKimy)|[<img src="https://img.shields.io/badge/Github-black?style=for-the-badge&logo=github&logoColor=white" alt="Github Blog Badge"/>](https://github.com/dayeong233)|[<img src="https://img.shields.io/badge/Github-black?style=for-the-badge&logo=github&logoColor=white" alt="Github Blog Badge"/>](https://github.com/kybeen)|[<img src="https://img.shields.io/badge/Github-black?style=for-the-badge&logo=github&logoColor=white" alt="Github Blog Badge"/>](https://github.com/Taerogrammer)|
| **💻 Developer** | **🎨 Designer** | **💻 Developer** | **💻 Developer** |
<br>




<!-- ========================



## 👩‍💻🧑‍💻 Authors

<table>
  <tr align=center>
    <td><img src="https://github.com/hyunjuntyler/readme-templates/assets/120548537/43640bd5-32f0-4b71-8753-1a47454ae502"></td>
    <td><img src="https://github.com/hyunjuntyler/readme-templates/assets/120548537/43640bd5-32f0-4b71-8753-1a47454ae502"></td>
    <td><img src="https://github.com/hyunjuntyler/readme-templates/assets/120548537/43640bd5-32f0-4b71-8753-1a47454ae502"></td>
    <td><img src="https://github.com/hyunjuntyler/readme-templates/assets/120548537/43640bd5-32f0-4b71-8753-1a47454ae502"></td>
  <tr align=center>
    <td>Link</td>
    <td>Link</td>
    <td>Link</td>
    <td>Link</td>
  </tr>
    <tr align=center>
    <td>Bazzi</td>
    <td>Dana</td>
    <td>Rei</td>
    <td>Ted</td>
  </tr>
  <tr align=center>
    <td>Developer</td>
    <td>Designer</td>
    <td>Developer</td>
    <td>Developer</td>
  </tr>
</table> -->
