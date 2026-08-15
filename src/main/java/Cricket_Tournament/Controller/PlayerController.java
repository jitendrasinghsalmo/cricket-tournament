package Cricket_Tournament.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Cricket_Tournament.Entity.Player;
import Cricket_Tournament.Entity.Team;
import Cricket_Tournament.Repository.PlayerRepository;
import Cricket_Tournament.Repository.TeamRepository;

@Controller
public class PlayerController {
    
    @Autowired private PlayerRepository playerRepo;
    @Autowired private TeamRepository teamRepo;

    @GetMapping("/addPlayer/{teamId}")
    public String addPlayerPage(@PathVariable Long teamId, Model m) {
        m.addAttribute("teamId", teamId);
        m.addAttribute("player", new Player());
        return "addPlayer"; 
    }

    @PostMapping("/savePlayer")
    public String savePlayer(@ModelAttribute Player player, @RequestParam Long teamId) {
        Team team = teamRepo.findById(teamId).orElse(null);
        player.setTeam(team);
        playerRepo.save(player);
        
        return "redirect:/viewPlayers/" + teamId; 
    }

    @GetMapping("/viewPlayers/{teamId}")
    public String viewPlayers(@PathVariable Long teamId, Model m) {
        m.addAttribute("players", playerRepo.findByTeamId(teamId));
        m.addAttribute("teamId", teamId); 
        return "viewPlayers"; 
    }

    @GetMapping("/editPlayer/{id}")
    public String editPlayer(@PathVariable Long id, Model m) {
        java.util.Optional<Player> p = playerRepo.findById(id);
        
        if(p.isPresent()) {
            m.addAttribute("player", p.get());
            if(p.get().getTeam() != null) {
                m.addAttribute("teamId", p.get().getTeam().getId());
            }
            return "editPlayer"; 
        } else {
            return "redirect:/teams"; 
        }
    }
    
    @GetMapping("/deleteAllPlayers/{teamId}")
    public String deleteAllPlayers(@PathVariable Long teamId) {
        var players = playerRepo.findByTeamId(teamId);
        playerRepo.deleteAll(players);
        return "redirect:/viewPlayers/" + teamId;
    }
    
    @GetMapping("/addPlayer")
    public String showAddPlayerPage(Model model) {
        model.addAttribute("teams", teamRepo.findAll());
        model.addAttribute("player", new Player());
        return "addPlayer";
    }

    @PostMapping("/updatePlayer")
    public String updatePlayer(@ModelAttribute Player player, @RequestParam Long teamId) {
        Player existing = playerRepo.findById(player.getId()).orElseThrow();
        existing.setPlayerName(player.getPlayerName());
        existing.setAge(player.getAge());
        existing.setJerseyNumber(player.getJerseyNumber());
        existing.setRole(player.getRole());
        existing.setBattingStyle(player.getBattingStyle());
        existing.setBowlingStyle(player.getBowlingStyle());
        playerRepo.save(existing);
        
        return "redirect:/viewPlayers/" + teamId;
    }

    @GetMapping("/deletePlayer/{id}")
    public String deletePlayer(@PathVariable Long id, @RequestParam Long teamId) {
        playerRepo.deleteById(id);
        return "redirect:/viewPlayers/" + teamId;
    }
}