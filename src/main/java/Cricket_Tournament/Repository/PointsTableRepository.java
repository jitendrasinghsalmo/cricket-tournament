package Cricket_Tournament.Repository;

import Cricket_Tournament.Entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface PointsTableRepository extends JpaRepository<PointsTable, Long> {
    // Unique record ke liye
    PointsTable findByTeamAndTournament(Team team, Tournament tournament);
    
    // Position ke liye sorted list
    List<PointsTable> findByTournamentOrderByPointsDescNetRunRateDesc(Tournament tournament);
}