#!/bin/bash
while [ 1 ]; do
	rm playernumbers.txt
	rm lottery_numbers.txt
	touch playernumbers.txt
	touch lottery_numbers.txt
	clear
	echo -n "Sistestage Kasutajanimi: "
	read name
	if [[ -z $name ]]; then
		name="Unknown"
	fi
		echo "Kasutaja:" $name
	echo "Sisestage viis (5) lotonumbrit vahemikus 1-50"
	echo "Vormistus on järgmine: nr1 nr2 nr3 nr4 nr5"
	echo -n "Numbrid: "
	read nr1 nr2 nr3 nr4 nr5

	#Test numbrid:
	#nr1=12
	#nr2=13
	#nr3=14
	#nr4=15
	#nr5=16
	kontrolli_nr () {
		local nr=$1
		if [[ $nr =~ ^[0-9]+$ ]]; then
			if [[ $nr -gt 0 && $nr -lt 51 ]]; then
				if [[ $nr -ne $2 && $nr -ne $3 && $nr -ne $4 && $nr -ne $5 ]]; then
					echo $nr >> playernumbers.txt
				fi
			else
			echo "Nr pole vahemikus"
			fi
		else
		echo "Vale vormistus"
		fi
	}

	kontrolli_nr "$nr1" "$nr2" "$nr3" "$nr4" "$nr5" || exit 1
	kontrolli_nr "$nr2" "$nr1" "$nr3" "$nr4" "$nr5" || exit 1
	kontrolli_nr "$nr3" "$nr1" "$nr2" "$nr4" "$nr5" || exit 1
	kontrolli_nr "$nr4" "$nr1" "$nr2" "$nr3" "$nr5" || exit 1
	kontrolli_nr "$nr5" "$nr1" "$nr2" "$nr3" "$nr4" || exit 1
clear
	MAXCOUNT=5
	count=0

	while [ "$count" -lt "$MAXCOUNT" ]; do
	    number=$((RANDOM % 49 + 1))

	    if ! grep -qx "$number" lottery_numbers.txt 2>/dev/null; then
	        echo "$number" >> lottery_numbers.txt
	        count=$((count + 1))
	    fi
	done




	input="lottery_numbers.txt"
	i=1
	t=0
	while IFS= read -r line
		do
				nr="nr$i"

				if [[ "$line" -eq "${!nr}" ]]; then
					((t++))
				fi
		((i++))
	done < "$input"
	echo "======================"
	echo "Tulemus"
	echo "======================"
	echo "Kasutaja: "$name
	echo "Valitud numbrid: $nr1 $nr2 $nr3 $nr4 $nr5"
	echo -n "Loositud numbrid: "
	cat lottery_numbers.txt | xargs
	if [[ $t -eq 5 ]]; then
		echo "Tabamusi 5/5, JACKPOT"
		elif [[ $t -eq 4 ]]; then
			echo "Tabamusi 4/5, väga hea tulemus"
			elif [[ $t -eq 3 ]]; then
				echo "Tabamusi 3/5, hea tulemus"
				elif [[ $t -eq 2 ]]; then
				echo "Tabamusi 2/5, Kaks tabamust"
					elif [[ $t -eq 1 ]]; then
					echo "Tabamusi 1/5, Üks tabamus"
						else
							echo "0/5 gg"
	fi
	date
echo "Uuesti? y/n"
read vastus
if ["$vastus" = "n"] || [ "$vastus" = "N"]; then
break
fi
done
