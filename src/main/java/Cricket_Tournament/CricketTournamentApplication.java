package Cricket_Tournament;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication(scanBasePackages = {"Cricket_Tournament"})
public class CricketTournamentApplication {

	public static void main(String[] args) {
		ConfigurableApplicationContext context = SpringApplication.run(CricketTournamentApplication.class, args);
	}

}
