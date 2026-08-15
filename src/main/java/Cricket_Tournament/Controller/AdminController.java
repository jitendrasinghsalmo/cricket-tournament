package Cricket_Tournament.Controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Cricket_Tournament.Entity.Match;
import Cricket_Tournament.Entity.Player;
import Cricket_Tournament.Entity.Team;
import Cricket_Tournament.Entity.Tournament;
import Cricket_Tournament.Entity.Users;
import Cricket_Tournament.Repository.MatchRepository;
import Cricket_Tournament.Repository.PlayerRepository;
import Cricket_Tournament.Repository.PointsTableRepository;
import Cricket_Tournament.Repository.TeamRepository;
import Cricket_Tournament.Repository.TournamentRepository;
import Cricket_Tournament.Repository.UserRepository;
import Cricket_Tournament.Service.PlayerService;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private PointsTableRepository pointsTableRepository;
    
    @Autowired
    private PlayerRepository playerRepository; 
  
    @Autowired 
    private TeamRepository teamRepo;
    
    @Autowired 
    private TournamentRepository tourRepo;

    @Autowired
    private MatchRepository matchRepo;

    @Autowired 
    private UserRepository userRepo;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private PlayerService playerService;

    // 1. Admin Home Page with Session Check
    @GetMapping("/admin/home")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminHome(Principal principal, HttpSession session) {
        if (principal != null && session.getAttribute("user") == null) {
            userRepo.findByEmail(principal.getName()).ifPresent(user -> session.setAttribute("user", user));
        }
        return "admin_home"; 
    }
    
    @GetMapping("/admin/specific-home")
    @PreAuthorize("hasRole('ADMIN')")
    public String specificHome(Model model) {
        model.addAttribute("teams", teamRepo.findAll());
        return "home"; 
    }
    
    @GetMapping("/admin/pointsTable")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminPointsTable(@RequestParam(required = false) Long tournamentId, Model model) {
        model.addAttribute("tournaments", tourRepo.findAll());
        if (tournamentId != null) {
            Tournament tournament = tourRepo.findById(tournamentId).orElse(null);
            if (tournament != null) {
                model.addAttribute("pointsList", pointsTableRepository.findByTournamentOrderByPointsDescNetRunRateDesc(tournament));
            } else {
                model.addAttribute("pointsList", pointsTableRepository.findAll());
            }
            model.addAttribute("selectedTournamentId", tournamentId);
        } else {
            model.addAttribute("pointsList", pointsTableRepository.findAll()); 
        }
        return "viewPointsTable"; 
    }
    
    // ==================== TEAM CRUD ====================

    @GetMapping("/admin/teams")
    @PreAuthorize("hasRole('ADMIN')")
    public String manageTeams(Model m) {
        m.addAttribute("teams", teamRepo.findAll());
        return "admin_teams"; 
    }

    @GetMapping("/admin/addTeamPage")
    @PreAuthorize("hasRole('ADMIN')")
    public String showAddTeamPage() {
        return "add_team"; 
    }
    
    @GetMapping("/admin/deleteAllTeams")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteAllTeams() {
        teamRepo.deleteAll();
        return "redirect:/admin/teams";
    }

    @PostMapping("/admin/addTeam")
    @PreAuthorize("hasRole('ADMIN')")
    public String addTeam(@ModelAttribute Team team) {
        teamRepo.save(team);
        return "redirect:/admin/teams";
    }
    
    @GetMapping("/admin/editTeam/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String showEditForm(@PathVariable Long id, Model m) {
        Team team = teamRepo.findById(id).orElse(null);
        m.addAttribute("team", team);
        return "edit_team"; 
    }

    @PostMapping("/admin/updateTeam")
    @PreAuthorize("hasRole('ADMIN')")
    public String updateTeam(@ModelAttribute Team team) {
        teamRepo.save(team); 
        return "redirect:/admin/teams";
    }
    
    @GetMapping("/admin/deleteTeam/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteTeam(@PathVariable Long id) {
        teamRepo.deleteById(id);
        return "redirect:/admin/teams";
    }
    
    // ==================== PLAYER CRUD ====================

    @GetMapping("/admin/team/{teamId}/players")
    @PreAuthorize("hasRole('ADMIN')")
    public String viewAdminTeamPlayers(@PathVariable Long teamId, Model model) {
        Team team = teamRepo.findById(teamId).orElse(null);
        List<Player> players = playerRepository.findByTeamId(teamId); 
        model.addAttribute("team", team);
        model.addAttribute("players", players);
        model.addAttribute("teamId", teamId);
        return "viewPlayers";
    }

    @GetMapping("/admin/addPlayer/{teamId}")
    @PreAuthorize("hasRole('ADMIN')")
    public String addPlayerPage(@PathVariable Long teamId, Model model) {
        Team team = teamRepo.findById(teamId).orElse(null);
        Player player = new Player();
        model.addAttribute("team", team);
        model.addAttribute("player", player);
        model.addAttribute("teamId", teamId);
        return "addPlayer"; 
    }

    @PostMapping("/admin/savePlayer")
    @PreAuthorize("hasRole('ADMIN')")
    public String savePlayer(@RequestParam Long teamId, @ModelAttribute Player player) {
        Team team = teamRepo.findById(teamId).orElse(null);
        player.setTeam(team);
        playerRepository.save(player);
        return "redirect:/admin/team/" + teamId + "/players";
    }

    @GetMapping("/admin/editPlayer/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String editPlayerPage(@PathVariable Long id, Model model) {
        Player player = playerRepository.findById(id).orElse(null);
        model.addAttribute("player", player);
        if (player != null && player.getTeam() != null) {
            model.addAttribute("teamId", player.getTeam().getId());
        }
        return "editPlayer"; 
    }

    @PostMapping("/admin/updatePlayer")
    @PreAuthorize("hasRole('ADMIN')")
    public String updatePlayer(@RequestParam Long teamId, @ModelAttribute Player player) {
        Team team = teamRepo.findById(teamId).orElse(null);
        player.setTeam(team);
        playerRepository.save(player);
        return "redirect:/admin/team/" + teamId + "/players";
    }

    @GetMapping("/admin/deletePlayer/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String deletePlayer(@RequestParam Long teamId, @PathVariable Long id) {
        playerRepository.deleteById(id);
        return "redirect:/admin/team/" + teamId + "/players";
    }

    @GetMapping("/admin/deleteAllPlayers/{teamId}")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteAllPlayers(@PathVariable Long teamId) {
        List<Player> players = playerRepository.findByTeamId(teamId);
        playerRepository.deleteAll(players);
        return "redirect:/admin/team/" + teamId + "/players";
    }

    // ==================== TOURNAMENT CRUD ====================

    @GetMapping("/admin/tournaments")
    @PreAuthorize("hasRole('ADMIN')")
    public String manageTournaments(Model m) {
        m.addAttribute("tournaments", tourRepo.findAll());
        return "admin_tournaments"; 
    }
    
    @GetMapping("/admin/deleteAllTournaments")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteAllTournaments() {
        tourRepo.deleteAll();
        return "redirect:/admin/tournaments";
    }

    @GetMapping("/admin/addTournamentPage")
    @PreAuthorize("hasRole('ADMIN')")
    public String showAddTournamentPage() {
        return "add_tournament"; 
    }

    @PostMapping({"/admin/saveTournament", "/admin/addTournament"})
    @PreAuthorize("hasRole('ADMIN')")
    public String saveTournament(@ModelAttribute Tournament tournament) {
        tourRepo.save(tournament); 
        return "redirect:/admin/tournaments";
    }

    @GetMapping("/admin/editTournament/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String showEditTournamentForm(@PathVariable Long id, Model m) {
        Tournament tournament = tourRepo.findById(id).orElse(null);
        m.addAttribute("tournament", tournament);
        return "edit_tournament"; 
    }

    @PostMapping("/admin/updateTournament")
    @PreAuthorize("hasRole('ADMIN')")
    public String updateTournament(@ModelAttribute Tournament tournament) {
        tourRepo.save(tournament); 
        return "redirect:/admin/tournaments";
    }

    @GetMapping("/admin/search")
    @PreAuthorize("hasRole('ADMIN')")
    public String globalSearch(@RequestParam("keyword") String keyword, Model model) {
        model.addAttribute("teams", teamRepo.findByTeamNameContainingIgnoreCase(keyword));
        model.addAttribute("tournaments", tourRepo.findByTournamentNameContainingIgnoreCase(keyword));
        model.addAttribute("matches", matchRepo.findByVenueContainingIgnoreCase(keyword));
        model.addAttribute("users", userRepo.findByNameContainingIgnoreCaseOrEmailContainingIgnoreCase(keyword, keyword));
        model.addAttribute("players", playerRepository.findByPlayerNameContainingIgnoreCase(keyword));
        
        return "admin_search_results"; 
    }

    @GetMapping("/admin/deleteTournament/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteTournament(@PathVariable Long id) {
        tourRepo.deleteById(id);
        return "redirect:/admin/tournaments";
    }   

    // ==================== MATCH CRUD ====================

    @GetMapping("/admin/matches")
    @PreAuthorize("hasRole('ADMIN')")
    public String viewMatches(Model model) {
        model.addAttribute("matches", matchRepo.findAll());
        return "admin_matches";
    }

    @GetMapping("/admin/addMatchPage")
    @PreAuthorize("hasRole('ADMIN')")
    public String addMatchPage(Model model) {
        model.addAttribute("teams", teamRepo.findAll());
        model.addAttribute("tournaments", tourRepo.findAll());
        return "add_match";
    }
    
    @GetMapping("/admin/deleteAllMatches")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteAllMatches() {
        matchRepo.deleteAll();
        return "redirect:/admin/matches";
    }

    @PostMapping("/admin/addMatch")
    @PreAuthorize("hasRole('ADMIN')")
    public String saveMatch(@ModelAttribute Match match) {
        matchRepo.save(match);
        return "redirect:/admin/matches";
    }

    @GetMapping("/admin/editMatch/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String editMatchPage(@PathVariable Long id, Model model) {
        Match match = matchRepo.findById(id).orElse(null);
        model.addAttribute("match", match);
        model.addAttribute("teams", teamRepo.findAll());
        model.addAttribute("tournaments", tourRepo.findAll());
        return "edit_match";
    }

    @PostMapping("/admin/updateMatch")
    @PreAuthorize("hasRole('ADMIN')")
    public String updateMatch(@ModelAttribute Match match) {
        matchRepo.save(match);
        return "redirect:/admin/matches";
    }

    @GetMapping("/admin/deleteMatch/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteMatch(@PathVariable Long id) {
        matchRepo.deleteById(id);
        return "redirect:/admin/matches";
    }
        
    // ==================== USERS CRUD ====================

    @GetMapping("/admin/users")
    @PreAuthorize("hasRole('ADMIN')")
    public String manageUsers(Model m) {
        m.addAttribute("users", userRepo.findAll());
        return "admin_users"; 
    }

    @GetMapping("/admin/deleteAllUsers")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteAllUsers() {
        // Admin accounts ko secure rakhne ke liye sirf non-admin users ya saare delete karne ka logic
        List<Users> allUsers = userRepo.findAll();
        for(Users u : allUsers) {
            if(!"ADMIN".equals(u.getRole())) {
                userRepo.delete(u);
            }
        }
        return "redirect:/admin/users";
    }
    
    
    @GetMapping("/admin/addUserPage")
    @PreAuthorize("hasRole('ADMIN')")
    public String showAddUserPage() {
        return "add_user"; 
    }

    @PostMapping("/admin/addUser")
    @PreAuthorize("hasRole('ADMIN')")
    public String addUser(@ModelAttribute Users user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/admin/editUser/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String showEditUserForm(@PathVariable Long id, Model m) {
        Users user = userRepo.findById(id).orElse(null);
        m.addAttribute("user", user);
        return "edit_user"; 
    }

    @PostMapping("/admin/updateUser")
    @PreAuthorize("hasRole('ADMIN')")
    public String updateUser(@ModelAttribute Users user) {
        Users existing = userRepo.findById(user.getId()).orElse(null);
        if (existing != null && !user.getPassword().equals(existing.getPassword())) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        userRepo.save(user); 
        return "redirect:/admin/users";
    }

    @GetMapping("/admin/toggleBlock/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String toggleBlockUser(@PathVariable Long id) {
        Users user = userRepo.findById(id).orElse(null);
        if (user != null) {
            user.setBlocked(!user.isBlocked());
            userRepo.save(user);
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/admin/deleteUser/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteUser(@PathVariable Long id) {
        userRepo.deleteById(id);
        return "redirect:/admin/users";
    }
}