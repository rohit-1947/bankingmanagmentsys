package com.obms.service;

import java.util.Arrays;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.obms.model.Account;
import com.obms.model.RaiseTicket;
import com.obms.model.Transaction;
import com.obms.model.User;
import com.obms.repository.AccountRepository;
import com.obms.repository.RaiseQueryRepository;
import com.obms.repository.TransactionRepository;
import com.obms.repository.UserRepository;

@Service
public class AdminDAO {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private AccountRepository accRepo;
	@Autowired
	private TransactionRepository transacRepo;
	@Autowired
	private RaiseQueryRepository queryRepo;
	



	public List<Account> showAllUserDetails() {
		return accRepo.findAll();
	}
	public void updateBalance(Account x,Transaction t) {
		accRepo.save(x);
		transacRepo.save(t);
	}

	public List<Transaction> fetchTransactionOfUser(int acc) {
		List<Transaction> list = transacRepo.findAllByFrom(acc);
		List<Transaction> list2 = transacRepo.findAllByTo(acc);
		for (Transaction t : list) {
			t.setType("DEBIT");
		}
		for (Transaction t : list2) {
			t.setType("CREDIT");
		}
		list.addAll(list2);
		return list;
	}

	public void closeAcccount(int id) {
		userRepo.deleteById(id);

	}


	public User getUser(int id) {
		Optional<User> list = userRepo.findById(id);
		if (list.isPresent()) {
			return list.get();
		} else {
			return null;
		}
	}

	public List<Account> searchByAccount(int account) {
		return accRepo.findAllById(Arrays.asList(account));
	}

	public List<RaiseTicket> getAllQuery() {
		return queryRepo.findAll();
	}

	public RaiseTicket getQueryById(int id) {
		Optional<RaiseTicket> list = queryRepo.findById(id);
		if (list.isPresent()) {
			return list.get();
		} else {
			return null;
		}
	}

	public void updateQueryStatus(RaiseTicket query) {
		queryRepo.save(query);
	}


	public Account getAccountbyAccountNumber(int accno)
	{
		return accRepo.findByAccno(accno);
	}
	
	public List<RaiseTicket> getSolvedTickets(String status)
	{
		return queryRepo.findByStatus(status);
	}
	public List<Account> getAllUserAccounts()
	{
		return accRepo.findByAccType("SAVINGS");
	}
	public List<Transaction> getAllTransactions()
	{
		return transacRepo.findAll();
	}
	public List<User> getAllUsers()
	{
		return userRepo.findByRole("USER");
	}
}
