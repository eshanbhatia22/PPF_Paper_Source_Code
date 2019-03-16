num=0

while read line
do
    let num=num+1

    app1=`sed -n ''$num'p' mix_48_workloads.txt | awk '{print $1}'`
    app2=`sed -n ''$num'p' mix_48_workloads.txt | awk '{print $2}'`
    app3=`sed -n ''$num'p' mix_48_workloads.txt | awk '{print $3}'`
    app4=`sed -n ''$num'p' mix_48_workloads.txt | awk '{print $4}'`

    echo $app1 $app2 $app3 $app4
done < mix_48_numbers.txt
