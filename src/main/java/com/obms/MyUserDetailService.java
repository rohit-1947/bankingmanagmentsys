package com.obms;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.obms.model.User;
import com.obms.repository.UserRepository;

@Service
public class MyUserDetailService implements UserDetailsService{
	@Autowired
	UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<User> user= userRepository.findByEmail(username);
		
		if (user.isPresent()) {
			return new MyUserDetails(user.get());
		}else {
			user.orElseThrow(() -> new UsernameNotFoundException("Not Found :" + username));
			return null;
		}
	}

}
