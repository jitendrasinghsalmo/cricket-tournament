package Cricket_Tournament.Service;
import Cricket_Tournament.Repository.PlayerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PlayerServiceImpl implements PlayerService {

    @Autowired
    private PlayerRepository playerRepository;

    @Override
    public List<Cricket_Tournament.Entity.Player> getPlayersByTeamId(Long teamId) {
        return playerRepository.findByTeamId(teamId);
    }
}