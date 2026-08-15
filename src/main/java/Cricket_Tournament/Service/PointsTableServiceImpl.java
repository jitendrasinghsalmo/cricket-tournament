package Cricket_Tournament.Service;

import Cricket_Tournament.Entity.*;
import Cricket_Tournament.Repository.PointsTableRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PointsTableServiceImpl implements PointsTableService {
    @Autowired private PointsTableRepository ptRepo;

    @Transactional
    @Override
    public void updatePointsTable(Match m) {
        if (m.getStatus() == MatchStatus.COMPLETED) {
            // Team A aur B ka stats update karo (Unique Tournament ke saath)
            updateTeamStats(m.getTeamA(), m);
            updateTeamStats(m.getTeamB(), m);

            // NRR Calculation aur Save
            updateNRR(m);
            
            // Positions recalculate karo
            recalculatePositions(m.getTournament());
        }
    }

    @Override
    public Page<PointsTable> getAllPointsTable(Pageable pageable) {
        return ptRepo.findAll(pageable);
    }

    private void updateTeamStats(Team team, Match m) {
        // Unique record find karo (Team + Tournament)
        PointsTable pt = ptRepo.findByTeamAndTournament(team, m.getTournament());
        
        if (pt == null) {
            pt = new PointsTable();
            pt.setTeam(team);
            pt.setTournament(m.getTournament());
            pt.setMatchesPlayed(0); 
            pt.setPoints(0);
            pt.setWon(0);
            pt.setLost(0);
            pt.setTie(0);
        }
        
        pt.setMatchesPlayed(pt.getMatchesPlayed() + 1);
        
        if (m.getWinner() == null) { // Tie
            pt.setTie(pt.getTie() + 1);
            pt.setPoints(pt.getPoints() + 1);
        } else if (m.getWinner().getId().equals(team.getId())) { // Win
            pt.setWon(pt.getWon() + 1);
            pt.setPoints(pt.getPoints() + 2);
        } else { // Loss
            pt.setLost(pt.getLost() + 1);
        }
        ptRepo.save(pt);
    }

    private void updateNRR(Match m) {
        PointsTable ptA = ptRepo.findByTeamAndTournament(m.getTeamA(), m.getTournament());
        PointsTable ptB = ptRepo.findByTeamAndTournament(m.getTeamB(), m.getTournament());
        
        double nrrA = (m.getRunsScoredA() / Math.max(1, m.getOversFacedA())) 
                    - (m.getRunsScoredB() / Math.max(1, m.getOversFacedB()));
        double nrrB = (m.getRunsScoredB() / Math.max(1, m.getOversFacedB())) 
                    - (m.getRunsScoredA() / Math.max(1, m.getOversFacedA()));
        
        if (ptA != null) { ptA.setNetRunRate(nrrA); ptRepo.save(ptA); }
        if (ptB != null) { ptB.setNetRunRate(nrrB); ptRepo.save(ptB); }
    }

    private void recalculatePositions(Tournament tournament) {
        List<PointsTable> list = ptRepo.findByTournamentOrderByPointsDescNetRunRateDesc(tournament);
        int pos = 1;
        for (PointsTable pt : list) {
            pt.setPosition(pos++);
            ptRepo.save(pt);
        }
    }
}