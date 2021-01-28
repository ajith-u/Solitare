def popCheck  column , row
	crt=false
	if(row >= $invisiblecard[$indexval[column]] and row < $card[$indexval[column]].getAllCards.length) 
	   value = $card[$indexval[column]].getCards(row) 
	   crt = true 
       while(row < ($card[$indexval[column]].getAllCards.length-1))
	      if ((value-1) != ($card[$indexval[column]].getCards(row+1)))
		     crt  = false
		     break
	      else 
	 	     value = $card[$indexval[column]].getCards (row+1)
	 	     row =row + 1
	      end
      end
    end
	return crt
end

def pushCheckAndSet column , row , pushcolumn , setter
	value = $card[$indexval[pushcolumn]].getCards(-1)
	val   = $card[$indexval[column]].getCards(row)	
	result = true 
	if  $card[$indexval[pushcolumn]].getAllCards.length != 0 and  value != (val+1) 
	   	result = false
	end
	stop = $card[$indexval[column]].getAllCards.length-1
	if result and setter
		i = 0 
		temparr = Array.new
		while  row <= stop
			temparr[i] = $card[$indexval[column]].getAllCards.pop
			i +=1
			stop -=1
		end
		while i > 0
			setval = temparr.pop 
			$card[$indexval[pushcolumn]].setoneCard setval
			i = i-1
		end

	end
 	return result 
end
