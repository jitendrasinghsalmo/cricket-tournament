package Cricket_Tournament.Service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import Cricket_Tournament.Entity.PointsTable;
import Cricket_Tournament.Entity.Team;
import Cricket_Tournament.Repository.PointsTableRepository;
import Cricket_Tournament.Repository.TeamRepository;

@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    private TeamRepository teamRepository;

    @Autowired 
    private PointsTableRepository pointsRepo;

    @Override
    public Team createTeam(Team team) {
        return teamRepository.save(team);
    }

    @Override
    public Team getTeamById(Long id) {
        return teamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Team not found with ID: " + id));
    }

    @Override
    public List<Team> getAllTeams() {
        return teamRepository.findAll();
    }

    // Pagination ke liye method jo 5 records per page dega
    @Override
    public Page<Team> getAllTeams(Pageable pageable) {
        return teamRepository.findAll(pageable);
    }

    @Override
    public Team updateTeam(Long id, Team team) {
        Team existingTeam = getTeamById(id);
        existingTeam.setTeamName(team.getTeamName());
        existingTeam.setCity(team.getCity());
        existingTeam.setCoachName(team.getCoachName());
        existingTeam.setOwnerName(team.getOwnerName());
        return teamRepository.save(existingTeam);
    }

    @Override
    public void deleteTeam(Long id) {
        Team team = getTeamById(id);
        teamRepository.delete(team);
    }

    @Override
    public void saveTeam(Team team) {
        Team savedTeam = teamRepository.save(team);
        
        PointsTable pt = new PointsTable();
        pt.setTeam(savedTeam);
        pt.setMatchesPlayed(0);
        pt.setWon(0);
        pt.setPoints(0);
        
        pointsRepo.save(pt);
    }
}