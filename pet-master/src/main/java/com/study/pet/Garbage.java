//package com.study.pet;
//
//import java.io.File;
//import java.io.IOException;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.nio.file.attribute.BasicFileAttributes;
//import java.util.concurrent.TimeUnit;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Service;
//
//import com.xcurenet.prs.attach.service.StreamingFileUtil;
//
//
//@Service
//
//public class Garbage {
//
//
//
//	private static final Logger log = LoggerFactory.getLogger(Garbage.class);
//
//	private static final String VIDEO_TMP_DIR = "C:\\Users\\1234\\git\\pet\\src\\main\\resources\\static\\image_information\\temp_img"; // 원하는 경로로 수정
//
//	private static final int DELETE_SEC = 7200;
//
//
//
//	@Scheduled(cron = "0 0 * * * ?") //1시간마다
//
//	public void userJob() throws Exception {
//
//		deleteFolders(DELETE_SEC);
//
//	}
//
//
//
//	public static void main(String[] args) {
//
//		deleteFolders(DELETE_SEC);
//
//	}
//
//
//
//	private static void deleteFolders(int sec) {
//	
//
//
//		File video = new File(StreamingFileUtil.VIDEO_TMP);
//
//		if (!video.isDirectory()) return;
//
//
//
//		for (File adminDirs : video.listFiles()) {
//
//			File files[] = adminDirs.listFiles();
//
//			if (files == null) continue;
//
//			for (File f : files) {
//
//				try {
//
//					long fModify = getSecondsFromModification(f);
//
//					if (fModify > sec) {
//
//						log.info("temp file delete : " + f.getAbsolutePath() + "  modify time(s) : " + fModify);
//
//						f.delete();
//
//					}
//
//				} catch (IOException e) {
//
//					e.printStackTrace();
//
//				}
//
//			}
//
//		}
//
//	}
//
//
//
//        // 파일의 수정한 날짜를 현재 시간 대비 경과 시간을 초로 환산 하여 리턴
//
//	private static long getSecondsFromModification(File f) throws IOException {
//
//		Path attribPath = f.toPath();
//
//		BasicFileAttributes basicAttribs = Files.readAttributes(attribPath, BasicFileAttributes.class);
//
//		return (System.currentTimeMillis() - basicAttribs.lastModifiedTime().to(TimeUnit.MILLISECONDS)) / 1000;
//
//	}
//
//}