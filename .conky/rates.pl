#!/usr/bin/perl

$file		= "/tmp/rates.txt";	# data file

#====================================================================================

if (-e $file){

	($fYear, $fMonth, $fDay, $fHour, $fMinute, $fsecond, $fzone) = split (/\:|\s|-/, `stat -c \%y $file`);
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

	$download = (!($fYear == $year + 1900 && $fMonth == $mon + 1 && $fDay == $mday) # not today's data
	   	    || (60*$hour+$min > 870 && 60*$fHour+$fMinute <= 870));             # time > 14:30 and file time <= 14:30, 14:30 ČNB data update, 870 = 14*60+30
}
else {$download = TRUE};
if ($download){
	`wget -O - "http://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.txt" > $file`;
}

($day, $month, $year, $wday) = split(/\.|\s#/,`head -n1 $file`);
print sprintf("%d", $day).". ".sprintf("%d", $month).". ".$year."     \$ ".rate("USD")." Kč, € ".rate("EUR")." Kč\n"; 

#====================================================================================

sub rate {
	# $_[0] Currency code
	return (split /\||\n/,`cat $file | grep -x "\.*\|$_[0]\|\.*"`)[4];
}