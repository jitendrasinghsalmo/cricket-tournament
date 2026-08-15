package Cricket_Tournament.Controller;

import Cricket_Tournament.Entity.PointsTable;
import Cricket_Tournament.Service.PointsTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PointsTableController {
    
    @Autowired 
    private PointsTableService pointsTableService;

    @GetMapping("/pointsTable")
    public String viewPointsTable(
            @RequestParam(defaultValue = "0") int page, 
            Model m) {
        
        // Uniform pagination: 5 records per page
        Page<PointsTable> pointsPage = pointsTableService.getAllPointsTable(PageRequest.of(page, 5));
        
        m.addAttribute("pointsList", pointsPage.getContent());
        m.addAttribute("currentPage", page);
        m.addAttribute("totalPages", pointsPage.getTotalPages());
        
        return "viewPointsTable";
    }
}