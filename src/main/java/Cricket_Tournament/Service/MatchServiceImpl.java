package Cricket_Tournament.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import Cricket_Tournament.Entity.Match;
import Cricket_Tournament.Repository.MatchRepository;

@Service
public class MatchServiceImpl implements MatchService {

    @Autowired
    private MatchRepository matchRepository;

    @Override
    public void save(Match match) {
        matchRepository.save(match);
    }

    @Override
    public Page<Match> getAllMatches(Pageable pageable) {
        return matchRepository.findAll(pageable);
    }

    @Override
    public Match getMatchById(Long id) {
        return matchRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteMatch(Long id) {
        matchRepository.deleteById(id);
    }
}