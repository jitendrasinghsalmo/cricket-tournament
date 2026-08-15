package Cricket_Tournament.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import Cricket_Tournament.Entity.Match;
import Cricket_Tournament.Entity.PointsTable;

public interface PointsTableService {
    void updatePointsTable(Match m);
    Page<PointsTable> getAllPointsTable(Pageable pageable);
}