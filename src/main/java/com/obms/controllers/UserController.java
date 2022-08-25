package com.obms.controllers;

import java.time.LocalDateTime;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.obms.model.RaiseTicket;
import com.obms.model.Transaction;
import com.obms.model.User;
import com.obms.service.UserDAO;

@Controller
@ComponentScan("com.obms.service")
public class UserController {
	
	String localuserid="userid";
	
	@Autowired
	private UserDAO userDAO;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@GetMapping("/")
	public String index() {
		return "index";
	}
	@GetMapping("/dashboard")
	public String dashboard() {
		return "dashboard";
	}
	@GetMapping("/signup")
	public String register() {
		return "signup";
	}
	@GetMapping("/UserDashboard")
	public String userdashboard() {
		return "UserDashboard";
	}


	@GetMapping("/fundtransfer")
	public String fundtransfer() {
		return "fundtransfer";
	}

	@GetMapping("/getBalance")
	@ResponseBody
	public String getBalance(@RequestParam("id") int id, @RequestParam("pin") String pin) {

		return userDAO.getBalance(id, pin);

	}

	@GetMapping("/profile")
	public String getUserProfileDetails(HttpSession session, HttpServletRequest request) {
		
		request.setAttribute("usermodel",
				userDAO.getUser(Integer.parseInt(String.valueOf(session.getAttribute(localuserid)))));
		return "profile";

	}

	@PostMapping("/transfer")
	public String transferFund(@RequestParam("id") int id, @RequestParam("accno") int accno,
			@RequestParam("ifsc") String ifsc, @RequestParam("accname") String accname,
			@RequestParam("amount") float amount, @RequestParam("mode") String mode, HttpServletRequest request) {
		String status="transacstatus";
		if (userDAO.findAccount(accno).isPresent()) {
			User user = userDAO.getUser(id);
			if (user.getAccount().getBal() > 0 && (user.getAccount().getBal() - amount) >= 0) {
				Transaction trans = new Transaction();
				trans.setDate(LocalDateTime.now());
				trans.setAmount(amount);
				trans.setMode(mode);
				trans.setFrom(user.getAccount().getAccno());
				trans.setType("DEBIT");
				trans.setTo(accno);

				userDAO.transferFund(trans);
				request.setAttribute("msg", "Transaction successfull");
				return status;
			} else {
				request.setAttribute("msg", "Insufficient Balance");
				return status;
			}
		} else {
			request.setAttribute("msg", "Invalid Account");
			return status;
		}
	}

	@GetMapping("/passbook")
	public String getAllTransaction(HttpSession session, HttpServletRequest request) {
		request.setAttribute("list",
				userDAO.getAllTransactions(Integer.parseInt(String.valueOf(session.getAttribute(localuserid)))));
		return "passbook";
	}

	@PostMapping("/editprofile")
	public String editProfile(@RequestParam("password") String password, @RequestParam("name") String name,
			@RequestParam("phone") String phone, @RequestParam("address") String address, @RequestParam("id") int id,
			@RequestParam("pin") int pin) {
		User u = userDAO.getUser(id);
		u.setName(name);
		u.setAddress(address);
		u.setPassword(passwordEncoder.encode(password));
		u.setPin(String.valueOf(pin));
		u.setPhone(phone);

		userDAO.updateUser(u);
		if (u.getRole().equals("ADMIN")) {
			return "redirect:/adminprofile";
		} 
		else
		{
			return "redirect:/profile";
		}

	}


	@PostMapping("/raisequery")
	public String raiseQuery(@RequestParam("id") int id, @RequestParam("query") String query) {
		RaiseTicket r = new RaiseTicket(query, "pending", LocalDateTime.now(), userDAO.getUser(id));
		userDAO.addQuery(r);
		return "redirect:/profile";
	}



}
