
def hintprintclm clm , i , pushclm = 0
	k = 1
	if(clm == 0)
       	print i ,"."
    end
    if $card[clm].getAllCards.length() == 0 
        print  "\t           "
    elsif i < $card[clm].getAllCards.length()
    	if(pushclm == 1)
    		print "\t+---------+".yellow
        else
       	    print "\t+---------+".green 
       	end
	else
	   	size = i - $card[clm].getAllCards.length()
	   	if size <= 1
	   		if pushclm == 1
	   			print "\t|         |".yellow
	   		else
	   		    print "\t|         |".green
	   		end
	   	elsif size == 2
	   		if (pushclm == 1)
	   			print "\t+---------+".yellow
	   		else
	   		    print "\t+---------+".green
	   		end
	   	else
	   		print "\t           "
	   	end
	end
end

def printclm clm , i
	k = 1
	if(clm == 0)
       	print " ",i ,"."
    end
    if $card[clm].getAllCards.length() == 0 
        print  "\t           "
    elsif i < $card[clm].getAllCards.length()
       	print "\t+---------+" 
	else
	   	size = i - $card[clm].getAllCards.length()
	   	if size <= 1
	   		print "\t|         |"
	   	elsif size == 2
	   		print "\t+---------+"
	   	else
	   		print "\t           "
	   	end
	end
end

def hintprintsecondclm clm , i , pushclm = 0
	    if $card[clm].getAllCards.length() == 0
	    	print "\t           "
		elsif i < $card[clm].getAllCards.length() 
          if ($card[clm].getCards i ) != 9
          	 if(pushclm == 1)
          	 	print "\t| #{$cardvalue[$card[clm].getCards i]}       |".yellow
          	 else

          	    print "\t| #{$cardvalue[$card[clm].getCards i]}       |".green
          	 end
          else
          	if(pushclm == 1)
          		print "\t| 10      |".yellow
          	else
          		print "\t| 10      |".green
            end
          end
        else
        	size = i - $card[clm].getAllCards.length()
        	if(size == 0 )
        	   if(pushclm == 1)
        	      print "\t|         |".yellow
        	   else
                  print "\t|         |".green
               end
            elsif(size == 1)
               if ($card[clm].getCards -1 ) != 9
               	    if ($card[clm].getAllCards.length()) > i  
               	       if(pushclm == 1)
               	       	    print "\t| #{$cardvalue[$card[clm].getCards i]}       |".yellow
               	       else
                         print "\t| #{$cardvalue[$card[clm].getCards i]}       |".green 
                       end
                    else
                       if(pushclm == 1)
                           print "\t|       #{$cardvalue[$card[clm].getCards -1]} |".yellow
                        else
                           print "\t|       #{$cardvalue[$card[clm].getCards -1]} |".green
                        end
                    end
               else
               	    if pushclm == 1
               	    	print "\t|      10 |".yellow
               	    else
               	    	print "\t|      10 |".green 
               	    end
               end
            else
                print "\t           "
            end
        end
end

def printsecondclm clm , i 
	    if $card[clm].getAllCards.length() == 0
	    	print "\t           "
		elsif i < $card[clm].getAllCards.length() 
          if ($card[clm].getCards i ) != 9
          	 print "\t| #{$cardvalue[$card[clm].getCards i]}       |"
          else
          	print "\t| 10      |"
          end
        else
        	size = i - $card[clm].getAllCards.length()
        	if(size == 0 )
               print "\t|         |"
            elsif(size == 1)
               if ($card[clm].getCards -1 ) != 9
               	    if ($card[clm].getAllCards.length()) > i  
                       print "\t| #{$cardvalue[$card[clm].getCards i]}       |" 
                    else
                       print "\t|       #{$cardvalue[$card[clm].getCards -1]} |"
                    end
               else
                    print "\t|      10 |" 
               end
            else
                print "\t           "
            end
        end
end





def display column = "1" , row = -1, pushcolumn = -1 
	system "cls"
	puts 
    puts "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tSetCards = #{$arrangedCards} / 8".green
	puts "\t     A     \t     B     \t     C     \t     D     \t     E     \t     F     \t     G     \t     H     \t     I     \t     J     \t" ;
    maxilen = $card[0].getAllCards.length()
    for i in (1..9)
       if (maxilen < $card[i].getAllCards.length() )
       	maxilen = $card[i].getAllCards.length()
       end
    end
    len = maxilen
    maxilen = maxilen + 6
    for i in (0..maxilen) 
	    for j in (1..2)
		    if j % 2 != 0
			    for clm in (0..9) 
				    if(column != "1" and $indexval[column] == clm and row <= i)
			        	hintprintclm clm , i 
			        elsif(column != "1" and $indexval[pushcolumn] == clm and ($card[$indexval[pushcolumn]].getAllCards.length-1) <=i )
			            hintprintclm clm , i , 1
			        else 
				       printclm clm , i
				    end
			    end
			    if i == (len +2)
			    	print "\t+---------+"
			    elsif i== (len+3) and $extracards.length() == 0
			    	print "\t|   #{"NO".green}    |"
			    elsif i==(len+3)
		    		leng=$extracards.length() / 10
		    		print "\t|  #{"#{leng} / 5".green}  |"
			    elsif i == (len+4)
			    	print "\t|         |"
                elsif i == (len+5)
                	print "\t+---------+"
			    end
		    else
			    for clm in (0..9)
				    if $invisiblecard[clm] > i
					    print "\t|         |"
				    else
					    if(column != "1" and $indexval[column] == clm and row <= i)
				    		hintprintsecondclm clm , i
				    	elsif(column != "1" and $indexval[pushcolumn] == clm and ($card[$indexval[pushcolumn]].getAllCards.length-1) <=i )
				    		hintprintsecondclm clm , i , 1
				    	else
				    		printsecondclm clm , i 
				    	end
				    end
			    end
			    if i== (len+1)
			    	print "\t     X     "
			    elsif i==(len +2)
			    	print "\t|         |"
			    elsif i== (len +3)
			    	print "\t|ExtraCard|"
			    elsif i == (len +4)
			    	print "\t|         |"
                end
		    end
		    puts
	    end
    end
end

                    

				    