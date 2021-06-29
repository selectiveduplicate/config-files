function fish_prompt
	# Change prompt color in case of an error 
	if test $status != 0
		set_color bf616a
		printf ';; '
	else
		set_color $fish_color_cwd
		printf ';; '
	end
end
