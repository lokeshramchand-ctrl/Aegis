package com.aegis.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.persistence.autoconfigure.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.aegis.auth.repository")
@EntityScan(basePackages = "com.aegis.auth.entity")
public class AegisBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(AegisBackendApplication.class, args);
	}

}
