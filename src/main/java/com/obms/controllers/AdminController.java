package com.obms.controllers;

import java.time.LocalDateTime;

import java.util.List;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.obms.model.Account;
import com.obms.model.RaiseTicket;
import com.obms.model.Transaction;
import com.obms.model.User;
import com.obms.service.AdminDAO;

@Controller
@ComponentScan("com.obms.service")
public class AdminController {
	String all="allUser";
	String back="redirect:/showall";
	@Autowired
	private AdminDAO adminDAO;
	
	@GetMapping("/showall")
	public String showAllUser(HttpServletRequest request) {
		request.setAttribute("all", adminDAO.showAllUserDetails()) ;
		return "adminshowusers";
	}
	@GetMapping("/AdminDashboard")
	public String admindashboard(HttpServletRequest request) {
		request.setAttribute(all, adminDAO.showAllUserDetails()) ;
		return "AdminDashboard";
	}

	
	@GetMapping("/viewdetail")
	public String showTransactOfUser(@RequestParam("id") int id, HttpServletRequest request) {
		User user= adminDAO.getUser(id);
		request.setAttribute("userdetail", user);
		request.setAttribute("usertransac", adminDAO.fetchTransactionOfUser(user.getAccount().getAccno()));
		return "viewdetail";
	}
	
	@GetMapping("/close")
	public String closeAccount(@RequestParam("id") int  id) {
		adminDAO.closeAcccount(id);
		return back;
	}
	
	@GetMapping("/adminprofile")
	public String getAdminProfileDetails(HttpSession session, HttpServletRequest request) {
		request.setAttribute("adminmodel", adminDAO.getUser(Integer.parseInt(String.valueOf(session.getAttribute("userid")))));
		return "adminprofile";
	}
	
	@GetMapping("/search")
	public String searchAccount(@RequestParam("account") int account, HttpServletRequest request) {
		request.setAttribute(all, adminDAO.searchByAccount(account)) ;
		return "adminshowusers";
	}
	
	@GetMapping("/getallquery")
	public String fetchAllQuery(HttpServletRequest request) {
		List<RaiseTicket> tickets= adminDAO.getAllQuery();
		request.setAttribute("querylist", tickets);
		return "adminquery";
	}
	
	@GetMapping("/status")
	public String resolveissue(@RequestParam("id") int id,HttpSession session) {
		RaiseTicket ticket= adminDAO.getQueryById(id);
		ticket.setStatus("complete");
		adminDAO.updateQueryStatus(ticket);
		return "redirect:/SolvedTickets";
	}

	@PostMapping("/credit")
	public String creditammount(@RequestParam("accno") String accno,@RequestParam("amount") float amount) {
		Account x=adminDAO.getAccountbyAccountNumber(Integer.parseInt(accno));
		x.setBal(x.getBal()+amount);
		Transaction trans = new Transaction();
		trans.setDate(LocalDateTime.now());
		trans.setAmount(amount);
		trans.setMode("CASH");
		trans.setFrom(11111111);
		trans.setType("CREDIT");
		trans.setTo(Integer.parseInt(accno));
		adminDAO.updateBalance(x,trans);
		return back;
	}
	@PostMapping("/debit")
	public String debitamount(@RequestParam("accno") String accno,@RequestParam("amount") float amount) {
		Account x=adminDAO.getAccountbyAccountNumber(Integer.parseInt(accno));
		if(x.getBal()<amount)
		{
			return back;
		}
		else
		{
		x.setBal(x.getBal()-amount);
		Transaction tran = new Transaction();
		tran.setDate(LocalDateTime.now());
		tran.setAmount(amount);
		tran.setMode("CASH");
		tran.setFrom(Integer.parseInt(accno));
		tran.setType("DEBIT");
		tran.setTo(11111111);
		adminDAO.updateBalance(x,tran);
		return back;
		}
		
	}
}
