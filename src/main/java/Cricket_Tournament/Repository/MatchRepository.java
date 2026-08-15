package Cricket_Tournament.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Cricket_Tournament.Entity.Match;

@Repository
public interface MatchRepository extends JpaRepository<Match,Long>{
	
	List<Match> findByVenueContainingIgnoreCase(String keyword);

}
