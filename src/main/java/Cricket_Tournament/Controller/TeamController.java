package Cricket_Tournament.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import Cricket_Tournament.Entity.Team;
import Cricket_Tournament.Repository.TeamRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class TeamController {
    @Autowired private TeamRepository repo;

    @GetMapping("/")
    public String addTeamPage() { return "addTeam"; }
    
    
    
 // Isse GET request accept ho jayegi aur aapka registration form khul jayega
    @GetMapping("/register-team")
    public String showRegistrationForm() {
        return "team_register"; // Agar aapke JSP ka naam team_register.jsp hai
    }

    @GetMapping("/viewTeam")
    public String viewTeams(
            @RequestParam(value = "page", defaultValue = "0") int page, 
            @RequestParam(value = "size", defaultValue = "6") int size, 
            Model m) {
        
        var teamPage = repo.findAllTeamsSorted(PageRequest.of(page, size));
        
        System.out.println("DEBUG: Page " + page + " - Total Elements from DB: " + teamPage.getTotalElements() + " - Fetched Size: " + teamPage.getContent().size());
        
        m.addAttribute("teams", teamPage.getContent());
        m.addAttribute("currentPage", page);
        m.addAttribute("totalPages", teamPage.getTotalPages());
        m.addAttribute("totalItems", teamPage.getTotalElements());
        
        return "viewTeam";
    }

    @GetMapping("/edit/{id}")
    public String editTeam(@PathVariable Long id, Model m) {
        m.addAttribute("team", repo.findById(id).get());
        return "editTeam";
    }

    @PostMapping("/updateTeam")
    public String updateTeam(@ModelAttribute Team team) {
        repo.save(team);
        repo.flush(); // Yeh cache ko instant flush karke DB se sync kar dega
        return "redirect:/viewTeam";
    }

    @GetMapping("/delete/{id}")
    public String deleteTeam(@PathVariable Long id) {
        repo.deleteById(id);
        return "redirect:/viewTeam";
    }

    // --- Delete All Teams Method ---
    @GetMapping("/deleteAllTeams")
    public String deleteAllTeams() {
        repo.deleteAll();
        return "redirect:/viewTeam";
    }
    

    // --- Payment & Registration Flow Methods ---

    @GetMapping("/team-register-page")
    public String showTeamRegisterPage() {
        return "team_register";
    }
    
    @GetMapping("/home")
    public String homePage() {
        return "home";
    }
    
    @PostMapping("/register-team")
    public String processTeamRegistration(
            @RequestParam("teamName") String teamName,
            @RequestParam("city") String city,
            @RequestParam("coachName") String coachName,
            @RequestParam("ownerName") String ownerName,
            @RequestParam("logoUrl") String logoUrl,
            @RequestParam("amount") int amount,
            HttpSession session) {
        
        session.setAttribute("pendingTeamName", teamName);
        session.setAttribute("pendingCity", city);
        session.setAttribute("pendingCoachName", coachName);
        session.setAttribute("pendingOwnerName", ownerName);
        session.setAttribute("pendingLogoUrl", logoUrl);
        session.setAttribute("paymentAmount", amount);

        return "redirect:/payment-page";
    }  
    
}