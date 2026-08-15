package Cricket_Tournament.Service;

import java.util.List;

import Cricket_Tournament.Entity.Player;

public interface PlayerService {
	
	List<Player> getPlayersByTeamId(Long teamId);

}
