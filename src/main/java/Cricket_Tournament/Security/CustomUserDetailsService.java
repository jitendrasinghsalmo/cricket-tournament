package Cricket_Tournament.Security;

import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import Cricket_Tournament.Repository.UserRepository;
import Cricket_Tournament.Entity.Users;
import java.util.Collections;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.authentication.LockedException;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private UserRepository userRepo;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // Optional handle karne ke liye .orElseThrow() sahi se set hai
        Users user = userRepo.findByEmail(email)
            .orElseThrow(() -> new UsernameNotFoundException("User not found: " + email));
        
        // Yahan block check lagaya hai - agar blocked hoga toh login nahi hoga
        if (user.isBlocked()) {
            throw new LockedException("Your account has been blocked by the admin.");
        }
        
        return new org.springframework.security.core.userdetails.User(
            user.getEmail(), 
            user.getPassword(), 
            Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole().name()))
        );
    }
}