// testDTO.java
package com.study.pet;

import lombok.Data;

@Data
public class testDTO {

     int test_id; // 추가: test_id 필드
     String test_title;
     String test_content;
     String test_writer;
     String created;
     int image_id; // 추가: image_id 필드
     String image_path;
}
