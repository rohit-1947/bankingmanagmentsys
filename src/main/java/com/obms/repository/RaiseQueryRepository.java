package com.obms.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.obms.model.RaiseTicket;

@Repository
public interface RaiseQueryRepository extends JpaRepository<RaiseTicket, Integer> {
	List<RaiseTicket> findByStatus(String status);

}
