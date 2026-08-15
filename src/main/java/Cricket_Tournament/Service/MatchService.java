package Cricket_Tournament.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import Cricket_Tournament.Entity.Match;

public interface MatchService {
    void save(Match match);
    
    Page<Match> getAllMatches(Pageable pageable);
    
    Match getMatchById(Long id);
    
    void deleteMatch(Long id);
}