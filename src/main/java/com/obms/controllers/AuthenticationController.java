package com.obms.controllers;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.obms.model.Account;
import com.obms.model.User;
import com.obms.service.UserDAO;

@Controller
@ComponentScan("com.obms.service")
public class AuthenticationController {
	

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/logoutsession")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/error")
	@ResponseBody
	public String error() {
		return "WELCOME BUDDY";
	}
	
	@GetMapping("/check")
	@ResponseBody
	public String check() {
		return "WELCOME CHECK";
	}

	@GetMapping("/loginsetsession")
	public String login(HttpServletRequest request) {
		
		String username="";
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
		   username = ((UserDetails)principal).getUsername();
		} else {
		   username = principal.toString();
		}
		Optional<User> userlist= userDAO.findByEmail(username);
		if (userlist.isPresent()) {
			User user = userlist.get();
			HttpSession session = request.getSession(true);
			session.setAttribute("userid", user.getId());
			session.setAttribute("role", user.getRole());
			if(user.getRole().equals("ADMIN")) {
				return "redirect:/AdminDashboard";
			}
			else
			{
				return "redirect:/UserDashboard";
			}
		}else {
			return "error";
		}
	}

	@PostMapping("/register")
	public String register(HttpSession session,@RequestParam("email") String email, @RequestParam("password") String password,
			@RequestParam("name") String name, @RequestParam("pin") String pin, @RequestParam("phone") String phone,
			@RequestParam("state") String state, @RequestParam("address") String address,
			@RequestParam("aadharproof") String aadharproof,@RequestParam("role") String role,@RequestParam("acctype") String acctype) throws NoSuchAlgorithmException {

		User user = new User(name, email, passwordEncoder.encode(password), pin, phone, role, state, address, "Not Approved", aadharproof,
				null);
		String ifsc="";
		switch (state) {
		case "Jharkhand":
			ifsc= "JHO5678";
			break;
		case "West Bengal":
			ifsc= "WBO5678";
			break;
		case "Orissa":
			ifsc= "ORO5678";
			break;
		case "Andhra Pradesh":
			ifsc= "APO5678";
			break;
		default:
			break;
		}
		
		Random rand=SecureRandom.getInstanceStrong(); 
		int rvalue=rand.nextInt(90000000);
		Account account = new Account(10000000 + rvalue, LocalDateTime.now(), acctype, ifsc,
				0, user);
		user.setAccount(account);
		
		userDAO.addUserToDB(user, account);
		
		if (String.valueOf(session.getAttribute("role")).equals("USER")){
		return "UserDashboard";
		}
		else
			return "AdminDashboard";
	}

}