def isgameover(hint=false)
	totCards=0
    isGameEnd = true                    # it checks the game is end
	if($extracards.empty? or hint)
		col=['A','B','C','D','E','F','G','H','I','J']
		i=0
		while(i<10 and isGameEnd)
			totCards=0
			row=$card[i].getAllCards.length()-1;  # give which card take use to check
			loop do  #checking any chance to again play
				j=0
				if !($card[$indexval[col[i]]].getAllCards.empty?)
					if(popCheck(col[i],row))
						10.times do
							if(i != j and pushCheckAndSet(col[i],row,col[j],false))
								if(hint)
									display(col[i],row,col[j])
								end
								isGameEnd=false
								break
							else
								j+=1
							end
						end
						if(isGameEnd)
							row-=1
						else
							break
						end
					else
						break
					end
				else
					0.upto(9) do |x| 
						totCards+=$card[x].getAllCards.length()
					end
					isGameEnd=false
					break
				end
			end
			i+=1
		end
	else
		0.upto(9) do |x| 
			totCards+=$card[x].getAllCards.length()
		end
	end
	if(totCards != 0 and totCards<10)
		isGameEnd=true
	else
		isGameEnd=false
	end
	return isGameEnd
end


def check_invisibleCards()      #check need to any invisisble card to visible 
	for i in (0..9)
		if($invisiblecard[i]!=0 and $invisiblecard[i]==$card[i].getAllCards.length())
			$invisiblecard[i]-=1
		end
	end
end

def setExtraCardsInBoard()       #set extra card in the game
	seted=true
	for i in (0..9)
		if($card[i].getAllCards.length()==0)
			seted=false
			break
		end
	end
	if(seted)
		0.upto(9) { |i| $card[i].popedExtraCards($extracards.pop()) }
	end
	return seted
end


def isCardArranged(val)   #check the any card arrange,it return boolean 
	isArranged=true

	chkCard=$card[$indexval[val]].getAllCards  
	i=chkCard.length()-1         #total length of card array - 1
	if(i+1-$invisiblecard[$indexval[val]]>=13) #visible card have atleast 13 or more than 13
		min=i-12
		while (i>min and isArranged)   #last to 13 cards 
			if(chkCard[i]+1 != chkCard[i-1]) 
				isArranged=false
			end
			i-=1
		end
	else
		isArranged=false
	end

	if (isArranged)  #pop the arranged card
		$card[$indexval[val]].deleteCards(13)    
	end

	return isArranged
end


def save()                #save the game if user terminate
	file=File.open("savefile.txt","w")
    line=""
	for i in (0..9)                         # cards in board
		len=$card[i].getAllCards.length()
		for j in (0..len-1)
			line += $card[i].getCards(j).to_s + " " 
		end
		file.write(line,"\n")
		line=""
	end

    for i in (0..$extracards.length()-1)  #extra cards 
		line += $extracards[i].to_s + " "
	end
	file.write(line,"\n")

	line=""
	for i in (0..$invisiblecard.length()-1)  #invisible cards 
		line += $invisiblecard[i].to_s + " "
	end
	file.write(line,"\n")

	file.close()

end

def loadSavedFile()               #load the save file
	totCards=0
	file=File.open("savefile.txt","r")
	val=Array.new
	10.times do |x|                       #set cards in the board
		line = file.readline()
		i=0
		while(line!="\n")
			space=line.index(' ')
			val[i] = line[0..(space-1)].to_i
			line[0..space]=""             #delete the few chatacters in the string
			i+=1
		end
		totCards+=i
		$card[x].loadCards(val)
		val=Array.new
	end

    i=0
	line=file.readline()
	while(line!="\n")                        #set extra Cards
		space=line.index(' ')
		$extracards[i] = line[0..space-1].to_i
		line[0..space]=""  
		i+=1
	end
	totCards+=i

	i=0
	line=file.readline()
	while(line!="\n")                        #set invisible Cards
		space=line.index(' ')
		$invisiblecard[i] = line[0..space-1].to_i
		line[0..space]=""  
		i+=1
	end
    $arrangedCards=((104-totCards)/13)
                  
	file.close()
end