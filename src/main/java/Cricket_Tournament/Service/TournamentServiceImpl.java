package Cricket_Tournament.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import Cricket_Tournament.Entity.Tournament;
import Cricket_Tournament.Repository.TournamentRepository;

@Service
public class TournamentServiceImpl implements TournamentService {

    @Autowired
    private TournamentRepository tournamentRepository;

    @Override
    public Page<Tournament> getAllTournaments(Pageable pageable) {
        return tournamentRepository.findAll(pageable);
    }

    @Override
    public void saveTournament(Tournament tournament) {
        tournamentRepository.save(tournament);
    }

    @Override
    public Tournament getTournamentById(Long id) {
        return tournamentRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteTournament(Long id) {
        tournamentRepository.deleteById(id);
    }
}