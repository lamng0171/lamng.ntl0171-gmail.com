package com.vti.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class MessageUtils {
	private Properties properties;

	public MessageUtils() throws FileNotFoundException, IOException {
		properties = new Properties();
		properties.load(new FileInputStream("src\\main\\java\\resource\\message.properties"));
	}

	public String getProperty(String key) {
		return properties.getProperty(key);
	}
}
