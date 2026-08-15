package Cricket_Tournament.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import Cricket_Tournament.Entity.Team;
import Cricket_Tournament.Repository.TeamRepository;
import Cricket_Tournament.Service.PaymentService;
import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private TeamRepository teamRepository;

    @Value("${razorpay.key.id}")
    private String keyId;

    @GetMapping("/payment-page")
    public String showPaymentPage(Model model) {
        model.addAttribute("keyId", keyId);
        return "payment";
    }

    // Sirf amount lein taaki order create mein error na aaye
    @PostMapping("/create-order")
    @ResponseBody
    public String createOrder(@RequestParam("amount") int amount) {
        try {
            return paymentService.createOrder(amount);
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }               
    }

    @GetMapping("/payment-success")
    public String paymentSuccess(
            @RequestParam("paymentId") String paymentId,
            HttpSession session,
            Model model) {
        
        // Session se team details nikalein jo team_register se aayi thin
        String teamName = (String) session.getAttribute("pendingTeamName");
        String city = (String) session.getAttribute("pendingCity");
        String coachName = (String) session.getAttribute("pendingCoachName");
        String ownerName = (String) session.getAttribute("pendingOwnerName");
        String logoUrl = (String) session.getAttribute("pendingLogoUrl");

        // Database mein Team save karein
        if (teamName != null) {
            Team team = new Team();
            team.setTeamName(teamName);
            team.setCity(city);
            team.setCoachName(coachName);
            team.setOwnerName(ownerName);
            team.setLogoUrl(logoUrl);
            teamRepository.save(team);
        }

        model.addAttribute("teamName", teamName);
        model.addAttribute("paymentId", paymentId);

        return "success";
    }
}