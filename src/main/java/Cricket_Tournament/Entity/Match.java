package Cricket_Tournament.Entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "match")
public class Match {
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne 
    private Team teamA;
    
    @ManyToOne 
    private Team teamB;
    
    @ManyToOne 
    @JoinColumn(name = "tournament_id") 
    private Tournament tournament;
    
    private LocalDateTime matchDateTime;
    private String venue;
    
    @ManyToOne 
    private Team winner;
    
    @Enumerated(EnumType.STRING) 
    private MatchStatus status;

    @Column(name = "runs_scoreda") private Double runsScoredA = 0.0;
    @Column(name = "overs_faceda") private Double oversFacedA = 0.0;
    @Column(name = "runs_scoredb") private Double runsScoredB = 0.0;
    @Column(name = "overs_facedb") private Double oversFacedB = 0.0;

    public Match() {}

    // Getters and Setters (Return type Double rakha hai)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Team getTeamA() { return teamA; }
    public void setTeamA(Team teamA) { this.teamA = teamA; }
    
    public Team getTeamB() { return teamB; }
    public void setTeamB(Team teamB) { this.teamB = teamB; }
    
    public Tournament getTournament() { return tournament; }
    public void setTournament(Tournament tournament) { this.tournament = tournament; }
    
    public LocalDateTime getMatchDateTime() { return matchDateTime; }
    public void setMatchDateTime(LocalDateTime matchDateTime) { this.matchDateTime = matchDateTime; }
    
    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }
    
    public Team getWinner() { return winner; }
    public void setWinner(Team winner) { this.winner = winner; }
    
    public MatchStatus getStatus() { return status; }
    public void setStatus(MatchStatus status) { this.status = status; }

    public Double getRunsScoredA() { return runsScoredA; }
    public void setRunsScoredA(Double runsScoredA) { this.runsScoredA = runsScoredA; }
    
    public Double getOversFacedA() { return oversFacedA; }
    public void setOversFacedA(Double oversFacedA) { this.oversFacedA = oversFacedA; }
    
    public Double getRunsScoredB() { return runsScoredB; }
    public void setRunsScoredB(Double runsScoredB) { this.runsScoredB = runsScoredB; }
    
    public Double getOversFacedB() { return oversFacedB; }
    public void setOversFacedB(Double oversFacedB) { this.oversFacedB = oversFacedB; }
}