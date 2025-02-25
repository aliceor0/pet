//package com.study.pet;
//
//import java.io.File;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.List;
//
//// spring framework의 @Controller 어노테이션을 사용할 필요가 없습니다.
//public class DeleteController_4 {
//    public static void main(String[] args) {
//        String directoryPath = "C:\\Users\\1234\\git\\pet\\src\\main\\resources\\static\\image_4\\title_img";
//        String jdbcUrl = "jdbc:mysql://localhost:3306/pet"; // MySQL 데이터베이스 URL
//        String username = "root";
//        String password = "1234";
//
//        List<String> fileNames = getFileNames(directoryPath);
//        List<String> databaseImageNames = getDatabaseImageNames(jdbcUrl, username, password);
//
//        deleteFilesNotInDatabase(directoryPath, fileNames, databaseImageNames);
//    }
//
//    private static List<String> getFileNames(String directoryPath) {
//        List<String> fileNames = new ArrayList<>();
//        File directory = new File(directoryPath);
//        File[] files = directory.listFiles();
//        if (files != null) {
//            for (File file : files) {
//                if (file.isFile()) {
//                    fileNames.add(file.getName());
//                }
//            }
//        }
//        return fileNames;
//    }
//
//    private static List<String> getDatabaseImageNames(String jdbcUrl, String username, String password) {
//        List<String> imageNames = new ArrayList<>();
//        try (java.sql.Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
//             Statement statement = connection.createStatement();
//             ResultSet resultSet = statement.executeQuery("SELECT title_img FROM information_board")) {
//
//            while (resultSet.next()) {
//                imageNames.add(resultSet.getString("title_img"));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return imageNames;
//    }
//
//    private static void deleteFilesNotInDatabase(String directoryPath, List<String> fileNames, List<String> databaseImageNames) {
//        for (String fileName : fileNames) {
//            if (!databaseImageNames.contains(fileName)) {
//                // 파일 삭제
//                File file = new File(directoryPath + File.separator + fileName);
//                if (file.delete()) {
//                    System.out.println("File deleted successfully: " + fileName);
//                } else {
//                    System.out.println("Failed to delete the file: " + fileName);
//                }
//            }
//        }
//    }
//}
