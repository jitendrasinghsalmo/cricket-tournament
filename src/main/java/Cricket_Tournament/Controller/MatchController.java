package Cricket_Tournament.Controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import Cricket_Tournament.Entity.*;
import Cricket_Tournament.Repository.*;
import Cricket_Tournament.Service.*;

@Controller
public class MatchController {
    @Autowired private MatchRepository matchRepo;
    @Autowired private TeamRepository teamRepo;
    @Autowired private TournamentRepository tourRepo;
    @Autowired private PointsTableService pointsTableService;

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @GetMapping("/matches")
    public String list(
            @RequestParam(defaultValue = "0") int page, 
            Model m) {
        
        Page<Match> matchPage = matchRepo.findAll(PageRequest.of(page, 6));
        
        System.out.println("Total matches found: " + matchPage.getTotalElements()); 
        
        m.addAttribute("matches", matchPage.getContent());
        m.addAttribute("currentPage", page);
        m.addAttribute("totalPages", matchPage.getTotalPages());
        
        return "viewMatches";
    }

    @GetMapping("/addMatch")
    public String showAddMatchForm(Model m) {
        m.addAttribute("teams", teamRepo.findAll());
        m.addAttribute("tournaments", tourRepo.findAll());
        return "addMatch";
    }

    @PostMapping("/saveMatch")
    public String save(@RequestParam String venue, @RequestParam String matchDateTime,
                       @RequestParam Long teamAId, @RequestParam Long teamBId,
                       @RequestParam Long tournamentId, @RequestParam String status) {
        Match m = new Match();
        m.setVenue(venue);
        m.setMatchDateTime(LocalDateTime.parse(matchDateTime, formatter));
        m.setTeamA(teamRepo.findById(teamAId).get());
        m.setTeamB(teamRepo.findById(teamBId).get());
        m.setTournament(tourRepo.findById(tournamentId).get());
        m.setStatus(MatchStatus.valueOf(status));
        matchRepo.save(m);
        return "redirect:/matches";
    }

    @GetMapping("/editMatch/{id}")
    public String editMatch(@PathVariable Long id, Model m) {
        Match match = matchRepo.findById(id).orElseThrow();
        
        if (match.getRunsScoredA() == null) match.setRunsScoredA(0.0);
        if (match.getOversFacedA() == null) match.setOversFacedA(0.0);
        if (match.getRunsScoredB() == null) match.setRunsScoredB(0.0);
        if (match.getOversFacedB() == null) match.setOversFacedB(0.0);
        
        m.addAttribute("match", match);
        m.addAttribute("teams", teamRepo.findAll());
        m.addAttribute("tournaments", tourRepo.findAll()); // Tournament list add ki yahan
        return "editMatch";
    }
    
    @GetMapping("/deleteAllMatches")
    public String deleteAllMatches() {
    	matchRepo.deleteAll(); // Database ke saare matches delete kar dega
        return "redirect:/matches";
    }

    @PostMapping("/updateMatch")
    public String update(@RequestParam Long id, @RequestParam String status, 
                         @RequestParam String venue, @RequestParam String matchDateTime,
                         @RequestParam(required = false) Long winnerId,
                         @RequestParam Double runsScoredA, @RequestParam Double oversFacedA,
                         @RequestParam Double runsScoredB, @RequestParam Double oversFacedB) {
        
        Match m = matchRepo.findById(id).orElseThrow();
        m.setVenue(venue);
        m.setMatchDateTime(LocalDateTime.parse(matchDateTime.replace(" ", "T")));
        m.setStatus(MatchStatus.valueOf(status));
        m.setRunsScoredA(runsScoredA); 
        m.setOversFacedA(oversFacedA);
        m.setRunsScoredB(runsScoredB); 
        m.setOversFacedB(oversFacedB);
        
        m.setWinner(winnerId != null ? teamRepo.findById(winnerId).orElse(null) : null);
        
        pointsTableService.updatePointsTable(m);
        
        matchRepo.save(m);
        return "redirect:/matches";
    }

    @GetMapping("/deleteMatch/{id}")
    public String delete(@PathVariable Long id) {
        matchRepo.deleteById(id);
        return "redirect:/matches";
    }
}