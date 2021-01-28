require 'fox16'  
include Fox  
require 'colorize'
require 'win32/sound'
include Win32

$cardvalue = ["A",2,3,4,5,6,7,8,9,10,"J","Q","K"]

$app = FXApp.new
$app.create
def mbox(picName,caption,message)	
	pic=File.open("C:/Users/ajith/OneDrive/Desktop/card/#{picName}.png","rb")
	pic2=FXPNGIcon.new($app, pic.read)
	my=FXMessageBox.new($app, caption, message , pic2 , MBOX_OK,);
	my.execute
end

class Solitaire
	def initialize
		@setOfCards=Array.new
	end

	def loadCards val
	 	@setOfCards = val		
	end

	def setCards(val)
		@setOfCards.push(val);
	end

	def popedExtraCards val
		@setOfCards.push(val) 
	end

	def deleteCards val
		@setOfCards.pop(val) 
	end

	def getCards i
		@setOfCards[i]		
	end

	def getAllCards
		@setOfCards
	end

	def deleteAllCards
		len=self.getAllCards.length
		while(len!=0)
			@setOfCards.delete_at((len=len-1))
		end
	end

	def setoneCard val
		@setOfCards.push(val)
	end

end
$card = Array.new(10) {|i|  Solitaire.new}
$arrangedCards
$extracards=Array.new
$indexval = { "A" => 0 , "B" => 1 , "C" => 2 , "D" => 3 , "E" => 4, "F" => 5 , "G" => 6 ,"H" => 7 , "I" => 8 , "J" => 9 }
$invisiblecard = Array.new(10)


load 'hintpatter.rb'
load 'pushandpop.rb'
load 'functions.rb'
load 'help.rb'




#main
win=false
tabspace="\t\t\t\t\t\t\t\t\t\t\t"
nextline=""
20.times { nextline+="\n" }

begin
	loop do		
		$arrangedCards=0
		$invisiblecard = [5,5,5,5,4,4,4,4,4,4,4]
		startselection=Array.new    #starting 
		startselection[0]="New Game"
		option=3
		play=""    #use to get row and coloumn from user
		if(File.readable?("savefile.txt"))
			startselection[1] = "Continue"
		    startselection[2] = "Help"
		    startselection[3] = "exit"
			option=4
		else
		    startselection[1] = "Help"
			startselection[2] = "exit"
		end
	#display the option to user
		system("cls")

		puts nextline
		for i in (0..option)
			puts(tabspace + " #{(i!=option)?i+1:"\n"} #{startselection[i]}")
		end
		print(tabspace , " >>>>> ")
		useroption=gets.to_i
		
		if(useroption.to_s.length != 1)
			Dir.chdir "audio"
			Sound.play('Vampire Bite.wav')
			mbox("game_shop-128","Error","Warning! Invalid input...Give correct input")
			Dir.chdir ".."
			redo
		end

		color = nextline      # user after select the color the selection one in terminel(just for visible)                     
	    for i in (0..option)
	      color+=tabspace 
	      if(useroption-1==i)
	        color+=" #{(i!=option)?i+1:"\n"} #{startselection[i]}\n".green
	      else
	        color+=" #{(i!=option)?i+1:"\n"} #{startselection[i] }\n"
	      end
	    end
	    color+=tabspace + " >>>>> #{useroption}"


		if(useroption<1 or useroption>option)
			Dir.chdir "audio"
			Sound.play('Vampire Bite.wav')
			mbox("game_shop-128","Error","Warning! Invalid input...Give correct input")
			Dir.chdir ".."
		elsif(startselection[useroption-1]=="exit")
			system("cls")
			puts color
	        Dir.chdir "audio"
			Sound.play('GunCock.wav')
			Dir.chdir ".."
			sleep(2)
			system("cls")	
			break;
		elsif (startselection[useroption-1]=="Help")
			help();
		else
			system("cls")
			puts color
	        Dir.chdir "audio"
			Sound.play('GunCock.wav')
			Dir.chdir ".."
	      
			sleep(1)
			system("cls")
			if(startselection[useroption-1]=="Continue")
				loadSavedFile()
			else
				loop do
					system('cls')
					puts "#{ nextline}#{tabspace} 1.Easy\n#{tabspace} 2.Medium\n#{tabspace} 3.Hard"
					print("\n",tabspace , " >>>>> ")
					level=gets.to_i
					if(level==1)
						load'EasyLevel.rb'
						system('cls')
						puts "#{ nextline}#{tabspace}#{' 1.Easy'.green}\n#{tabspace} 2.Medium\n#{tabspace} 3.Hard"
						print("\n",tabspace , " >>>>> 1")
					elsif(level==2)
						load'MediumLevel.rb'
						system('cls')						
						puts "#{ nextline}#{tabspace} 1.Easy\n#{tabspace}#{' 2.Medium'.green}\n#{tabspace} 3.Hard"
						print("\n",tabspace , " >>>>> 2")
					elsif(level==3)
						load'HardLevel.rb'
						system('cls')						
						puts "#{ nextline}#{tabspace} 1.Easy\n#{tabspace} 2.Medium\n#{tabspace} #{'3.Hard'.green}"
						print("\n",tabspace , " >>>>> 3z")						
					else
						Dir.chdir "audio"
						Sound.play('Vampire Bite.wav')
						mbox("game_shop-128","Error","Invalid input")
						Dir.chdir ".."
						redo
					end
					Dir.chdir "audio"
					Sound.play('GunCock.wav')
					Dir.chdir ".."
					sleep(2)
					break
				end
				suffleAndDistrubute()
			end
			display()  #display the cards what now
			Dir.chdir "audio"
			Sound.play('shuffling-cards-6.wav')
			Dir.chdir ".."
			if(option==3)
				File.delete("savefile.txt")
			end
			loop do
				begin
					if($arrangedCards != 8)  #if not win the game
						check_invisibleCards() #any invisible card need visible now
						if(play!='T')
						    system("cls")
							display()  #display the cards what now
						end
						if(!isgameover())  #check the game is finish
							print("Where to drag/exit/extracard/Hint(T)/help        ")
							play=gets.chomp.upcase;
							if(play=="EXIT")
								save()
								break;
							elsif(play=="HELP")
								help()
							elsif(play=="X")
								if(!($extracards.empty?) and setExtraCardsInBoard())
									Dir.chdir "audio"
									Sound.play('shuffling-cards-6.wav')
									Dir.chdir ".."
									col=['A','B','C','D','E','F','G','H','I','J']
									for x in (0..9)                                  # check any card may be arranged
										if(isCardArranged(col[x]))
											$arrangedCards+=1
											#sound
										end
									end
								else
									if(!($extracards.empty?))
										Dir.chdir "audio"
										Sound.play('Vampire Bite.wav')
										mbox("playing-cards","Error","You cannot deal a new row while any columns are empty")
										Dir.chdir ".."
									else
										Dir.chdir "audio"
										Sound.play('Vampire Bite.wav')
										mbox("playing-cards","Error","! Extra cards all are used")
										Dir.chdir ".."
									end
								end
							elsif play=="T"
							 	isgameover(true)
							elsif(play.length<=3)
								cols=$card[$indexval[play[0]]].getAllCards.length()-1
								if(play>="A" and play<="J" and cols>=0)
								   	check=true
								   	if(play.length == 1)
								   		col=cols
								   		while(check)
									   		play=play[0]+col.to_s
								   			check=popCheck(play[0],play[1..2].to_i)
								   			col-=1
								   		end
								   		play=play[0]+((col+2).to_s)
								   		check=true
								   	else
								   		check=false
								   	end
								    if(check or (play[1..2].to_i >= $invisiblecard[$indexval[play[0]]]-1 and play[1..2].to_i <=cols and popCheck(play[0],play[1..2].to_i)))
										Dir.chdir "audio"
										Sound.play("Pop Cork.wav")
										Dir.chdir ".."
										c=play[0]
										r=play[1..2].to_i   
										print("Where to join                                    ")
										play=gets.chomp.upcase
										if(play>="A" and play<="J" and pushCheckAndSet(c,r,play,true))  
											Dir.chdir "audio"
											Sound.play("Cupboard Door Close.wav")
											Dir.chdir ".."
											if(isCardArranged(play))
												$arrangedCards+=1
												mbox("reward",'setCards',"#{$arrangedCards}/8")
											end
										else
											Dir.chdir "audio"
											Sound.play('Vampire Bite.wav')
											mbox("playing-cards","Error"," You can only put a card on another card if it is in the next card sequence.\n The order is: K(King),Q(Queen),J(Jack),10,9,8,7,6,5,4,3,2,A(Ace).")
											Dir.chdir ".."
										end
									else
										Dir.chdir "audio"
										Sound.play('Vampire Bite.wav')
										mbox("playing-cards","Error","You can only put a card on another card if it is in the next card sequence.\n The order is: K(King),Q(Queen),J(Jack),10,9,8,7,6,5,4,3,2,A(Ace).")
										Dir.chdir ".."
									end
								else
									Dir.chdir "audio"
									Sound.play('Vampire Bite.wav')
									mbox("playing-cards","Error","You can only put a card on another card if it is in the next card sequence.\n The order is: K(King),Q(Queen),J(Jack),10,9,8,7,6,5,4,3,2,A(Ace).")
									Dir.chdir ".."
								end
							else
								Dir.chdir "audio"
								Sound.play('Vampire Bite.wav')
								mbox("playing-cards","Error","You can only put a card on another card if it is in the next card sequence.\n The order is: K(King),Q(Queen),J(Jack),10,9,8,7,6,5,4,3,2,A(Ace).")
								Dir.chdir ".."
							end
						else
							Dir.chdir "audio"
							Sound.play('Vampire Bite.wav')
							mbox("playing-cards","NO MORE MOVES!"," \n You have run out of moves.\n Well Played!")
							Dir.chdir ".."
							gets.chomp
							break
						end
					else
						display
						mbox("game_shop-128","! You Won","Congratulation!...\n You set all the cards")
						$arrangedCards=0
						break
					end
					if(play=="EXIT")
						break
					end
			   	rescue Exception => e
		    		if(e.message == "")
		    			save()
		    			play="EXIT"
		    			break
		    		else
		    			Dir.chdir "audio"
						Sound.play('Vampire Bite.wav')
						mbox("playing-cards","Error","You can only put a card on another card if it is in the next card sequence.\n The order is: K(King),Q(Queen),J(Jack),10,9,8,7,6,5,4,3,2,A(Ace).")
						Dir.chdir ".."
						redo
			    	end
			    end
			end
		end
		if(play=="EXIT")
			break
		end
		0.upto(9){|i| $card[i].deleteAllCards }
	end

rescue Exception=>e
    if(e.message!="")
    	retry
    end
end