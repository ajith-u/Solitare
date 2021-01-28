$shuffle = Array.new(104);

def setval()
	arngval = Array.new(8){Array.new(13)};
	for i in 0..7
		for j in 0..12
			arngval[i][j] = rand(13);
		end
	end

	for i in 0..7
		for j in 0..12
			val = arngval[i][j];
			for k in 0..12
				if j != k and arngval[i][k] == val then
					arngval[i][k] = 13;
				end
			end
		end
	end

	run = true;
	for i in 0..7
		a = 0;
		for j in 0..12
			for k in 0..12
				if arngval[i][k] == a then
					run = false;
				end
			end
			b = 0;
			while (run)
				if b < 13 and arngval[i][b] == 13 then
					arngval[i][b] = a;
					run = false;
				end
				b += 1;
			end
			a += 1;
			run = true;
		end
	end
	k = 0;
	for i in 0..12
		for j in 0..7
			$shuffle[k] = arngval[j][i];
			k += 1;
		end
	end
end

def setExtraCards()
	for i in 0..49
		$extracards[i] = $shuffle.pop;
	end
end


def suffleAndDistrubute()
	setval();
	setExtraCards();

	j = 0;
	val = $shuffle.pop;
	13.times do
		for i in 0..9
			if j < 54 then
				$card[i].setCards(val);
				val = $shuffle.pop;
				j += 1;
			end
		end
	end
end
