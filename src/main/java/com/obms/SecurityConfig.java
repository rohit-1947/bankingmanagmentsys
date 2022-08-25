package com.obms;

import javax.sql.DataSource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	public SecurityConfig() {
   // Empty Constructor
 }

	@Autowired
	UserDetailsService userDetailsService;
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth, DataSource dataSource) throws Exception {
		 auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());
	}

	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
		.authorizeRequests()
		.antMatchers("/", "/login", "/register", "/check", "/error").permitAll()

		.antMatchers("/admin", "/showall", "/close", 
				"/adminprofile", "/search","/AdminDashboard").hasAuthority("ADMIN")
//		.antMatchers("/Managerdashboard","/ViewLoans","/getAllAccounts","/ManagerProfile","/ViewAllUsers","managershowusers").hasAuthority("MANAGER")
		
		.antMatchers("/user", "/dashboard",
				"/fundtransfer", "/getBalance",
				"/profile", "/transfer", "/passbook", 
				"/raisequery","UserDashboard").hasAuthority("USER")
		.antMatchers("/SolvedTickets","/PendingTickets","/getAllTransactions","/credit","/status","/getallquery").hasAnyAuthority("ADMIN")
		.antMatchers("/editprofile","/viewdetail").hasAnyAuthority("USER","ADMIN")
		 .and()
         .formLogin()
             .loginPage("/")
             .loginProcessingUrl("/login")
             .defaultSuccessUrl("/loginsetsession", true)
             .passwordParameter("password")
             .usernameParameter("username")
         .and()
         .logout()
             .logoutUrl("/logout")
             .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET")) 
             .clearAuthentication(true)
             .invalidateHttpSession(true)
             .logoutSuccessUrl("/logoutsession");
			
	}
	
	
	@Bean
	public BCryptPasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder(15);
	}

}
