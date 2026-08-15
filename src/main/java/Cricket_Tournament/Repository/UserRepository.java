package Cricket_Tournament.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Cricket_Tournament.Entity.Users;

@Repository
public interface UserRepository extends JpaRepository<Users,Long>{
	
	Optional<Users> findByEmail(String email);
	List<Users> findByNameContainingIgnoreCaseOrEmailContainingIgnoreCase(String name, String email);
	

}
