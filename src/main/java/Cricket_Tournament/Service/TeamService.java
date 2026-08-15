package Cricket_Tournament.Service;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import Cricket_Tournament.Entity.Team;

public interface TeamService {
    Team createTeam(Team team);
    Team getTeamById(Long id);
    List<Team> getAllTeams();
    Page<Team> getAllTeams(Pageable pageable); // Pagination ke liye
    Team updateTeam(Long id, Team team);
    void deleteTeam(Long id);
    void saveTeam(Team team);
}