package Cricket_Tournament.Controller;

import java.security.Principal;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import Cricket_Tournament.Entity.Role;
import Cricket_Tournament.Entity.Users;
import Cricket_Tournament.Repository.MatchRepository;
import Cricket_Tournament.Repository.PlayerRepository;
import Cricket_Tournament.Repository.TeamRepository;
import Cricket_Tournament.Repository.TournamentRepository;
import Cricket_Tournament.Repository.UserRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired private UserRepository userRepo;
    @Autowired private TeamRepository teamRepo;
    @Autowired private TournamentRepository tourRepo;
    @Autowired private MatchRepository matchRepo;
    @Autowired private PlayerRepository playerRepository;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private JavaMailSender mailSender;

    @GetMapping("/register")
    public String showRegisterPage() { return "register"; }

    @PostMapping("/register")
    public String register(@ModelAttribute Users user) {
        user.setRole(Role.USER); 
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);
        return "redirect:/login"; 
    }
    
    @GetMapping("/about")
    public String aboutPage() {
        return "about"; // ye WEB-INF/views/about.jsp ko load karega
    }
    
    @GetMapping("/contact")
    public String contactPage() {
        return "contact"; // Yeh contact.jsp ko load karega
    }
    
    @GetMapping("/privacy-policy")
    public String privacyPolicyPage() {
        return "privacy-policy"; 
    }

    @GetMapping("/terms-and-conditions")
    public String termsConditionsPage() {
        return "terms-conditions"; 
    }
    
    @GetMapping("/faq")
    public String faqPage() {
        return "faq"; // Yeh faq.jsp ko load karega
    }
    
    
    @GetMapping("/login")
    public String showLoginPage() { return "login"; }
    

    @GetMapping("/teams")
    public String viewTeams(
            @RequestParam(value = "page", defaultValue = "0") int page, 
            @RequestParam(value = "size", defaultValue = "6") int size, 
            Model model) {
        
        // Custom sorted query use ki hai taaki sorting aur cache sync ki problem na aaye
        var teamPage = teamRepo.findAllTeamsSorted(PageRequest.of(page, size));
        
        model.addAttribute("teams", teamPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", teamPage.getTotalPages());
        model.addAttribute("totalItems", teamPage.getTotalElements());
        
        return "viewTeam"; 
    }

    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model) {
        model.addAttribute("teams", teamRepo.findByTeamNameContainingIgnoreCase(keyword));
        model.addAttribute("tournaments", tourRepo.findByTournamentNameContainingIgnoreCase(keyword));
        model.addAttribute("matches", matchRepo.findByVenueContainingIgnoreCase(keyword));
        model.addAttribute("players", playerRepository.findByPlayerNameContainingIgnoreCase(keyword));
        
        model.addAttribute("keyword", keyword);
        return "search_results"; 
    }

    // ==================== FORGOT & RESET PASSWORD ====================

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot_password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email, HttpSession session, Model model) {
        Users user = userRepo.findByEmail(email).orElse(null);
        if (user == null) {
            model.addAttribute("error", "Email registered nahi hai!");
            return "forgot_password";
        }

        String otp = String.format("%06d", new Random().nextInt(999999));
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Password Reset OTP");
            message.setText("Aapka OTP password reset karne ke liye yeh hai: " + otp);
            mailSender.send(message);
        } catch (Exception e) {
            model.addAttribute("error", "Email send karne mein error aayi hai!");
            return "forgot_password";
        }

        return "verify_otp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("otp") String otp, HttpSession session, Model model) {
        String sessionOtp = (String) session.getAttribute("otp");
        if (sessionOtp != null && sessionOtp.equals(otp)) {
            return "reset_password";
        } else {
            model.addAttribute("error", "Galat OTP enter kiya hai!");
            return "verify_otp";
        }
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam("newPassword") String newPassword, 
                                @RequestParam("confirmPassword") String confirmPassword, 
                                HttpSession session, Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords match nahi ho rahe hain!");
            return "reset_password";
        }

        String email = (String) session.getAttribute("email");
        if (email == null) {
            return "redirect:/forgot-password";
        }

        Users user = userRepo.findByEmail(email).orElse(null);
        if (user != null) {
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepo.save(user);
        }

        session.removeAttribute("otp");
        session.removeAttribute("email");

        return "redirect:/login?resetSuccess=true";
    }

    // ==================== CHANGE PASSWORD (LOGGED IN) ====================

    @GetMapping("/change-password")
    public String showChangePasswordPage() {
        return "change_password";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 Principal principal, Model model) {
        if (principal == null) {
            return "redirect:/login";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "New passwords match nahi ho rahe hain!");
            return "change_password";
        }

        Users user = userRepo.findByEmail(principal.getName()).orElse(null);
        if (user == null || !passwordEncoder.matches(oldPassword, user.getPassword())) {
            model.addAttribute("error", "Purana password galat hai!");
            return "change_password";
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepo.save(user);

        model.addAttribute("success", "Password successfully change ho gaya hai!");
        return "change_password";
    }
}