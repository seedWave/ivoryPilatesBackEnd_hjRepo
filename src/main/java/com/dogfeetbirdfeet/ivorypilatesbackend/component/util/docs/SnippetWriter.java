package com.dogfeetbirdfeet.ivorypilatesbackend.component.util.docs;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * @author nks
 * Service Test 위한 Snippet Writher
 * Service Test 에서 생성자 만들어 사용한다.
 */
public class SnippetWriter {

	private final Path snippetsDir;
	private final ObjectMapper om;

	public SnippetWriter(Path snippetsDir) {
		this.snippetsDir = snippetsDir;
		this.om = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
	}

	public void writeJson(String relative, Object obj) {
		try {
			Path path = ensurePath(relative);
			String json = om.writeValueAsString(obj);
			Files.writeString(path, json, StandardCharsets.UTF_8, StandardOpenOption.CREATE,
				StandardOpenOption.TRUNCATE_EXISTING);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public void writeAdoc(String relative, String content) {
		try {
			Path path = ensurePath(relative);
			Files.writeString(path, content, StandardCharsets.UTF_8, StandardOpenOption.CREATE,
				StandardOpenOption.TRUNCATE_EXISTING);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public void writeText(String relative, String content) {
		writeAdoc(relative, content);
	}

	private Path ensurePath(String relative) throws IOException {
		Path path = snippetsDir.resolve(relative);
		Files.createDirectories(path.getParent());
		return path;
	}
}
