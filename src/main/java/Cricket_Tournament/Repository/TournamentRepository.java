package Cricket_Tournament.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Cricket_Tournament.Entity.Tournament;

@Repository
public interface TournamentRepository extends JpaRepository<Tournament,Long> {
	List<Tournament> findByTournamentNameContainingIgnoreCase(String keyword);

}
