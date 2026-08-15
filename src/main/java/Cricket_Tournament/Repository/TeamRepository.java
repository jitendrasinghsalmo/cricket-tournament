package Cricket_Tournament.Repository;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import Cricket_Tournament.Entity.Team;

@Repository
public interface TeamRepository extends JpaRepository<Team, Long> {
    Team findByTeamName(String teamName);
    List<Team> findByTeamNameContainingIgnoreCase(String keyword);

    // Native SQL query use karne se Hibernate ka cache poori tarah bypass ho jata hai
    @Query(value = "SELECT * FROM team ORDER BY id ASC", 
           countQuery = "SELECT COUNT(*) FROM team", 
           nativeQuery = true)
    Page<Team> findAllTeamsSorted(Pageable pageable);
}