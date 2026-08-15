package Cricket_Tournament.Security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.context.support.WebApplicationContextUtils;

import Cricket_Tournament.Entity.Users;
import Cricket_Tournament.Repository.UserRepository;
import jakarta.servlet.http.HttpSession;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/login", 
                    "/register", 
                    "/forgot-password", 
                    "/verify-otp", 
                    "/reset-password", 
                    "/change-password",
                    "/css/**", 
                    "/js/**", 
                    "/error"
                ).permitAll()
                // Admin specific paths
                .requestMatchers("/admin/**").hasRole("ADMIN")
                // Allow both ADMIN and USER to access all player CRUD operations (Case-matched with Controller)
                .requestMatchers(
                    "/addPlayer/**", 
                    "/savePlayer/**", 
                    "/viewPlayers/**", 
                    "/editPlayer/**", 
                    "/deleteAllPlayers/**", 
                    "/updatePlayer/**", 
                    "/deletePlayer/**"
                ).hasAnyRole("ADMIN", "USER")
                .requestMatchers("/user/**").hasRole("USER")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("email") 
                .passwordParameter("password")
                .failureUrl("/login?error=true")
                .successHandler((request, response, authentication) -> {
                    HttpSession session = request.getSession();
                    
                    org.springframework.context.ApplicationContext ctx = 
                        WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
                    UserRepository userRepoRef = ctx.getBean(UserRepository.class);
                    
                    String email = authentication.getName();
                    Users loggedInUser = userRepoRef.findByEmail(email).orElse(null);
                    if (loggedInUser != null) {
                        session.setAttribute("user", loggedInUser);
                    }

                    boolean isAdmin = authentication.getAuthorities().stream()
                            .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
                    if (isAdmin) {
                        response.sendRedirect(request.getContextPath() + "/admin/home");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                })
                .permitAll()
            )
            .logout(logout -> logout
                .logoutSuccessUrl("/login?logout=true")
                .permitAll()
            );

        return http.build();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers("/WEB-INF/views/**");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}