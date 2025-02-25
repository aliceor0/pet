// testController.java
package com.study.pet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
public class testController {

    @Autowired
    private testDAO testDAO;

    @GetMapping("/test")
    public String test() {
        return "test";
    }

    @PostMapping("/dotest")
    public String doTest(
            @RequestParam("test_title") String test_title,
            @RequestParam("test_writer") String test_writer,
            @RequestParam("test_content") String[] test_content,
            @RequestParam("test_image") MultipartFile[] test_images) throws IOException {

        LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String created = currentTime.format(formatter);

        String savePath = "C:\\Users\\1234\\git\\pet\\src\\main\\resources\\static\\image";
        String uploadFolderPath = Paths.get(savePath).toString();

        String[] imagePaths = new String[test_images.length];
        for (int i = 0; i < test_images.length; i++) {
            MultipartFile file = test_images[i];
            if (file != null && !file.isEmpty()) {
                String test_image = file.getOriginalFilename();
                String ori_file_name = System.currentTimeMillis() + "_" + test_image;
                String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
                file.transferTo(new File(filePath));
                imagePaths[i] = ori_file_name;
            } else {
                imagePaths[i] = null;
            }
        }

        for (String imagePath : imagePaths) {
            System.out.println("Uploaded File Name: " + imagePath);
        }

        int n;
        for (int i = 0; i < test_content.length; i++) {
            n = testDAO.insertTest(test_title, test_content[i], test_writer, created);
            int testId = testDAO.getLastInsertedInfoId();
            n = testDAO.insertImage(testId, imagePaths[i]);
        }

        return "redirect:/test";
    }

}
