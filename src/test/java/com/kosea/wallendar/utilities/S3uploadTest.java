package com.kosea.wallendar.utilities;

import java.io.File;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kosea.wallendar.service.S3UploadService;


@SpringBootTest
public class S3uploadTest {
	@Autowired
	S3UploadService uploader;

	@Test
	public void up() throws Exception {
		
		uploader.delete("DgOOtYwUwAEoNQ8.jpg");
		
	}
}
