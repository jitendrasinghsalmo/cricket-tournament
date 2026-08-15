package Cricket_Tournament.Security;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import java.util.*;
import Cricket_Tournament.Entity.Users;

public class CustomUserDetails implements UserDetails {
    private Users user;
    public CustomUserDetails(Users user) { this.user = user; }

    @Override 
    public String getPassword() { return user.getPassword(); }

    @Override 
    public String getUsername() { return user.getEmail(); } // Email as username

    @Override 
    public Collection getAuthorities() { 
        return Collections.singleton(new SimpleGrantedAuthority("ROLE_" + user.getRole().name())); 
    }

    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { return true; }
}