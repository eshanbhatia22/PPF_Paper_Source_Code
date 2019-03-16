num=0

while read line
do
    let num=num+1

    line1=`sed -n ''$num'p' mix_48_numbers.txt | awk '{print $1}'`
    line2=`sed -n ''$num'p' mix_48_numbers.txt | awk '{print $2}'`
    line3=`sed -n ''$num'p' mix_48_numbers.txt | awk '{print $3}'`
    line4=`sed -n ''$num'p' mix_48_numbers.txt | awk '{print $4}'`

    app1=`sed -n ''$line1'p' traces_48.txt`
    app2=`sed -n ''$line2'p' traces_48.txt`
    app3=`sed -n ''$line3'p' traces_48.txt`
    app4=`sed -n ''$line4'p' traces_48.txt`
    echo $app1 $app2 $app3 $app4
done < mix_48_numbers.txt
