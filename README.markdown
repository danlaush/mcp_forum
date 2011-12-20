==MCP Applicants Question Forum

This app is designed to be a simple to use and simple to read web space for [AIESEC US](http://aiesecus.org) MCP candidates to answer questions from stakeholders in the runup to yearly elections.

This is more a proof of concept/ practice with RoR. AIESEC conversations should happen on the internal platform.



DESIGN NOTES

Users will go to the home page and see all questions that have been posted, with nested replies from MCP candidates.

Users
	basic users need no account, can post questions (with spam check), answer questions (with spam check), view candidate list and profile
	candidates can log in, edit their information, answer questions, post their OWN questions, view candidate list and profile
	admins can log in, edit their information, edit candidates' information, create new administrators and candidates, answer questions, post questions, view candidate list and profile
	super admins can log in, edit their information, edit candidates' and admins' users, create new super admin admins and candidates, answer, questions, post questions, view candidate list and profile

	All MCP candidates will have their own user accounts.
	Accounts will be created for them by an admin.
	Candidates can update their passwords
	Candidates can update their answers
	Candidates can update their text color
	
	
Questions
	Posts are text-only, paragraphs only
	Posts have two levels of nesting
		one generally for MCP answers
		two generally for followup or further discussion
	content: text
	author: string
	lc: string
	email: string
		
	


TODO
	update user model: 
		fix default color- remove #
		add prof pic support
	update user controller:
		get new, get edit (/app/views/user/_user.html.erb)
			color picker, pic upload
		post create
			email new users