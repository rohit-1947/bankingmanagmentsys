package com.obms.repository;

import java.util.List;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.obms.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer>{

	User findByEmailAndPassword(String email, String password);

	Optional<User> findByIdAndPin(int id, String pin);

	Optional<User> findByEmail(String email);
	
	List<User> findByRole(String role);
	
	
	

}
