// testDAO.java
package com.study.pet;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface testDAO {

    int getLastInsertedInfoId();

    int insertImage(int testId, String imagePath); // 메서드명 수정

    int insertTest(String testTitle, String testContent, String testWriter, String created); // 메서드명 수정
}
