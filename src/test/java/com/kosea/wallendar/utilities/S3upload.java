package com.kosea.wallendar.utilities;

import java.io.File;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
public class S3upload {
	@Autowired
	S3uploader uploader;

	@Test
	public void up() throws Exception {
		
		File file = new File("C:/Users/user/Downloads/tests3.jpg");
		
	}
}
