def help()
	system("cls");
puts("
	    ---#{"How to play".green}:
                >>> #{"K, Q, J, 10, 9, 8, 7, 6, 5, 4, 3, 2, A.".yellow}
                >>> #{"You need to arrange 8 sets in the above given sequence to win the game.".yellow}

		#{"Coloumn represents various sets, A, B, C, D, E, F, G, H, I, J.
		   Row represents the number which is in respect with the sequence, 1, 2....n.".yellow}

		---#{"How to drag".green}:
		    >>> #{"By giving the coloumn name and coressponding row number".yellow} 
		        For Example --- #{"giving".yellow} B3#{", drags a card from".yellow} Bth #{"coloumn's".yellow} 3rd #{"row.".yellow}
		    >>> #{"By giving the column name".green}
		        For Example --- #{"Giving ".yellow} B#{", drags the card according to the sequence.".yellow}

		---#{"How to join".green}:
			>>> #{"By giving the coloumn name the user can join the respective card to a set.".yellow}
			    For Example --- #{"Giving ".yellow}J#{", joins the respective card to the coloumn ".yellow} J#{".".white}

	    ---#{"How to add a ExtraCard".green}
	    	>>> #{"By giving X ExtraCard can be used.".yellow}
	    	>>> #{"This card adds a random card to the end of each set.".yellow}

	    ---#{"Hint".green}
	    	>>> #{"This is meant to be help the user to solve the sequence.".yellow}
	    	>>> #{"By giving ".yellow}T#{", you can recieve the assist of Hint.".yellow}
	    	>>> Green card #{"represents the card to be dragged.".yellow}
	    	>>> Yellow card #{"represents Where to join.".yellow}

	    ---#{"exit or Ctrl + 'C'".green}
	        >>> #{"Helps to exit the game.".yellow}
	        >>> #{"If you exit in halfway the game gives you an option to continue from where you left.".yellow}
	")

gets.chomp;
end