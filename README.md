# Oracle-Study
DBA과장님을 조르고 부탁드려서 배우게 된 오라클 공부 
- sql developer 설치(for 깃허브연동)
- 사내는 orange 툴을 사용(접근 제어 툴로는 샤크라 사용하여 둘 연동)
- SCOTT 계정으로 실습 -> SYSTEM(관리자) 계정 필요시 SQL PLUS로 계정변환

'''
 https://sunjung.tistory.com/m/27 사이트 참조하여 파일 설치 
https://github.com/GroovySunday/doit-oracle 깃허브 집파일 다운해서 SCOTT 계정 설정 -> 
CMD창에서 sqlplus system/oracle 로 접속 (잘됨 -> 비번은 oracle로 설치시 설정)
https://cafe.naver.com/doitstudyroom/27099 이 사이트 참조하여서 명령프롬프트 창에서 깃허브 집 압축 푼 ch03의 sql파일을 드래그하여 경로를 가져와서 
앞에 @로 엔터를 쳐서 scott연동 완료  ALTER USER SCOTT
 IDENTIFIED BY tiger
 ACCOUNT UNLOCK;
명령으로 SCOTT계정 비번은 TIGER로 접속할 수 있도록 함"
'''

- [오라클 설치 참고 사이트1](https://mydatanote.tistory.com/5?category=1053455)
- [오라클 설치 참고 사이트2](https://mydatanote.tistory.com/5)
- [오라클 설치 참고 사이트3_SQL Developer](https://secretpoten.tistory.com/377)
- [오라클 설치 참고 사이트4_SQL Developer와 Github 연동](https://fomaios.tistory.com/entry/Oracle-%EC%98%A4%EB%9D%BC%ED%81%B4-SQLDeveloper%EC%99%80-Github-%EC%97%B0%EB%8F%99%ED%95%98%EA%B8%B0feat-MacOS)

