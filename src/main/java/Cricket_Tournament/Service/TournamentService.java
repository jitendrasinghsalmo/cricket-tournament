package Cricket_Tournament.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import Cricket_Tournament.Entity.Tournament;

public interface TournamentService {
    Page<Tournament> getAllTournaments(Pageable pageable);
    void saveTournament(Tournament tournament);
    Tournament getTournamentById(Long id);
    void deleteTournament(Long id);
}