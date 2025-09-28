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
			Path p = ensurePath(relative);
			String json = om.writeValueAsString(obj);
			Files.writeString(p, json, StandardCharsets.UTF_8, StandardOpenOption.CREATE,
				StandardOpenOption.TRUNCATE_EXISTING);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public void writeAdoc(String relative, String content) {
		try {
			Path p = ensurePath(relative);
			Files.writeString(p, content, StandardCharsets.UTF_8, StandardOpenOption.CREATE,
				StandardOpenOption.TRUNCATE_EXISTING);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public void writeText(String relative, String content) {
		writeAdoc(relative, content);
	}

	private Path ensurePath(String relative) throws IOException {
		Path p = snippetsDir.resolve(relative);
		Files.createDirectories(p.getParent());
		return p;
	}
}
