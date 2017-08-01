note
    description : "root class of the application"
    date        : "$Date$"
    revision    : "$Revision$"

class
    APPLICATION inherit
	ES_TEST

create
	make
 
feature {NONE}
 
	make
		do
			create bkk_crypt
			add_boolean_case (agent t0)
			show_browser
			run_espec
		end

feature 
	t0: BOOLEAN
		do
			comment("t0: succeed?")
			Result := equal (bkk_crypt.crypt ("T-systems"), "T-systems") 
		end

feature
    bkk_crypt: BKKCRYPT 

end



