package pm.insa.com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class InsaApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(InsaApplication.class);
	}
	public static void main(String[] args) {
		System.out.println("=======================tomcat 실행 전==========================");
		SpringApplication.run(InsaApplication.class, args);
		System.out.println("=======================Spring 구동 후==========================");
	}
}
