package Cricket_Tournament.Controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import Cricket_Tournament.Entity.Tournament;
import Cricket_Tournament.Entity.TournamentStatus;
import Cricket_Tournament.Repository.TournamentRepository;
import Cricket_Tournament.Repository.PointsTableRepository; // 👈 Aapki points table repository
import Cricket_Tournament.Entity.PointsTable;             // 👈 Points table entity

@Controller
public class TournamentController {

    @Autowired 
    private TournamentRepository repo;

    @Autowired
    private PointsTableRepository pointsTableRepository; // 👈 Inject kiya

    @GetMapping("/tournaments")
    public String viewTournaments(
            @RequestParam(defaultValue = "0") int page, 
            Model model) {
        
        Page<Tournament> tournamentPage = repo.findAll(PageRequest.of(page, 6));
        
        // 🌟 Points table se saari entries nikal kar sirf Top 5 limit kiye
        List<PointsTable> allPoints = pointsTableRepository.findAll();
        List<PointsTable> top5Points = allPoints.stream().limit(5).collect(Collectors.toList());
        
        model.addAttribute("pointsList", top5Points); // 👈 Points table wala exact variable name
        model.addAttribute("tournaments", tournamentPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", tournamentPage.getTotalPages());
        
        return "viewTournaments";
    }

    @PostMapping("/saveTournament")
    public String saveTournament(@RequestParam String tournamentName, 
                                 @RequestParam String season,
                                 @RequestParam String startDate,
                                 @RequestParam String endDate,
                                 @RequestParam String status) {
        Tournament t = new Tournament();
        t.setTournamentName(tournamentName);
        t.setSeason(season);
        t.setStartDate(LocalDate.parse(startDate));
        t.setEndDate(LocalDate.parse(endDate));
        t.setStatus(TournamentStatus.valueOf(status));
        repo.save(t);
        return "redirect:/tournaments";
    }

    @GetMapping("/deleteTournament/{id}")
    public String deleteTournament(@PathVariable Long id, RedirectAttributes ra) {
        repo.deleteById(id);
        ra.addFlashAttribute("message", "Tournament Deleted Successfully!");
        return "redirect:/tournaments";
    }
    
    @Autowired
    private TournamentRepository tournamentRepository;

    @GetMapping("/deleteAllTournaments")
    public String deleteAllTournaments() {
        tournamentRepository.deleteAll();
        return "redirect:/tournaments";
    }
    
    @GetMapping("/editTournament/{id}")
    public String editForm(@PathVariable Long id, Model m) {
        Optional<Tournament> t = repo.findById(id);
        if(t.isPresent()) {
            m.addAttribute("tournament", t.get());
            return "editTournament";
        }
        return "redirect:/tournaments"; 
    }
    
    @GetMapping("/addTournament")
    public String showAddForm() {
        return "addTournament"; 
    }

    @PostMapping("/updateTournament")
    public String update(@ModelAttribute Tournament t) {
        repo.save(t); 
        return "redirect:/tournaments";
    }
}