package com.obms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.obms.model.Transaction;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Integer>{

	List<Transaction> findAllByFrom(int accno);

	List<Transaction> findAllByFromOrTo(int accno, int i);

	List<Transaction> findAllByTo(int accno);
	
}
