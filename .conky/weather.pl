#!/usr/bin/perl

use Switch;
use XML::Simple;

$action		= $ARGV[0];

# parameters for "update_info"
$code		= $ARGV[1];		# weather.com city code; 
					# see http://xoap.weather.com/search/search?where=%s where %s stands for your location
$units		= $ARGV[2];		# s = standard/imperial, m = metric
$forecast	= $ARGV[3];		# number of days for the forecast

# parameters for "symbol"
$day		= $ARGV[1];		# day displayed
$day_part	= $ARGV[2];		# 0 for day, 1 for night

# parameters for "temperature"
$day		= $ARGV[1];		# day displayed

$day_space	= "             ";	# space between short day names in day_names_cz_short

$file		= "/tmp/weather.xml";	# data file
$tempfile	= "/tmp/weather.tmp";	# temporary download file
$directory	= "~/.conky";

#====================================================================================

switch($action){
	case "cc_symbol" {
		&load_data;
		print(&translate($weather->{cc}->{icon},2));
	}
	case "cc_temperature" {
		&load_data;
		print $weather->{cc}->{tmp}." ˚C";
	}
	case "cc_moon" {
		&load_data;
		print &translate($weather->{cc}->{moon}->{t},3);
	}
	case "symbol" {
		&load_data;
		print &translate($weather->{dayf}->{day}[$day]->{part}[$day_part]->{icon},2);
	}
	case "temperature" {
		&load_data;
		print $temperature_space.$weather->{dayf}->{day}[$day]->{hi}."/".$weather->{dayf}->{day}[$day]->{low}."˚C";
	}
	case "update_info"{
		&update_load;
		&info;
	}
}

#====================================================================================

sub update_load {
	if(-e $file ){ # File does exist
		&load_data;	
		($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
		split /\/|\s|\:/, $weather->{cc}->{lsup};
		if ($_[3] == 12) {$_[3] = 0};
		if ($_[5] eq "PM") {$_[3] += 12};
		$update = !($_[0] == $mon + 1 && $_[1] == $mday && $_[2] == $year - 100 && $_[3] == $hour);
	}
	else {$update = TRUE};
	if ($update) {
		`wget -O $tempfile "http://xoap.weather.com/weather/local/$code?dayf=$forecast&unit=$units&cc=*"`;
		if (-s $tempfile > 0) {
			`mv -f $tempfile $file`;
			&load_data
		}
	}
}

sub info {
	split ",", $weather->{loc}->{dnam};
	print "  ".$_[0]." (".$weather->{loc}->{lat}." s. š.,  ".$weather->{loc}->{lon}." v. d.)\n";
	split /\/|\s|\:/, $weather->{cc}->{lsup};
	if ($_[3] == 12) {$_[3] = 0};
	if ($_[5] eq "PM") {$_[3] += 12};
	print "  Stav:   ".$_[3].":".$_[4].",   ".$_[1].". ".$_[0].". 20".$_[2]."             Update: ".&time12_24($weather->{loc}->{tm})."\n"
	     ."                              Tlak: ".&translate($weather->{cc}->{bar}->{d},2)." ".$weather->{cc}->{bar}->{r}." hPa\n"
	     ."                              Vítr: ".$weather->{cc}->{wind}->{s}." km/h  ".&translate($weather->{cc}->{wind}->{t},2)." (".$weather->{cc}->{wind}->{d}."˚)\n"
	     ."                              Vlhkost: ".$weather->{cc}->{hmid}." \%\n"
	     ."                              Rosný bod: ".$weather->{cc}->{dewp}." ˚C\n"
	     ."                              Viditelnost: ".$weather->{cc}->{vis}." km\n"
	     ."                              Východ: ".&time12_24($weather->{loc}->{sunr})."       Západ: ".&time12_24($weather->{loc}->{suns})."\n"
	     ."                              Měsíc: ".&translate($weather->{cc}->{moon}->{t},2)."\n\n"
	     ."   ".&day_names_cz_short(5)."\n\n\n";
}

sub load_data {
	$xml = new XML::Simple;	
	$weather = $xml->XMLin($file);
}

sub time12_24 {
	split /\:|\s/, $_[0];
	if ($_[0] == 12) {$_[0] = 0};
	if ($_[2] eq "PM") {$_[0] += 12};
	return "$_[0]".":"."$_[1]";
}

sub day_names_cz_short {
	# $_[0]; # number of days displayed, starting from the next day
	my $text = &translate($weather->{dayf}->{day}[1]->{t},3);
	for ($i = 2; $i < $_[0]+1; ++$i){
		$text .= $day_space.&translate($weather->{dayf}->{day}[$i]->{t},3);
	}
	return $text;
}

sub translate {
	#$_[0] String to be translated
	#$_[1] Column with translation
	my $temp = `cat $directory/weather.pl | grep -x "#\\s*$_[0]\\s*#.*\n"`;
	if ($temp eq ""){return $_[0]}
	else		{return (split /\s*#\s*|\s*\n/,$temp)[$_[1]]};
}

######################################
#                                    #
#       TRANSLATION TABLES           #
#                                    #
######################################

# DAYS

# Monday	# Pondělí	# Po
# Tuesday	# Úterý		# Út
# Wednesday	# Středa	# St
# Thursday	# Čtvrtek	# Čt
# Friday	# Pátek		# Pá
# Saturday	# Sobota	# So
# Sunday	# Neděle	# Ne

# WINDS

# N	# S
# E	# V
# S	# J
# W	# Z
# NE	# SV
# SE	# JV
# SW	# JZ
# NW	# SZ
# NNE	# SSV
# ENE	# VSV
# ESE	# VJV
# SSE	# JJV
# NNW	# SSZ
# WNW	# ZSZ
# WSW	# ZJZ
# SSW	# JJZ

# CONDITIONS

# Mostly Sunny			# a
# Mostly Clear			# a
# Fair				# b
# Partly Cloudy			# c
# Clouds Early / Clearing Late	# c
# Mostly Cloudy			# d
# Cloudy			# d
# Light Rain Early		# g
# Few Showers			# g
# Showers			# g
# Light Rain			# g
# PM Light Rain			# g
# Rain				# h
# Rain / Wind			# h
# Rain / Snow			# k
# Rain / Snow Showers		# k
# Light Snow			# k
# PM Light Snow			# k
# Scattered T-Storms		# f
# N/A				#  
# Fair and Windy		#  

# LUNAR PHASES 
# Codes are for a white font.
# New			# Nov			# 9
# Waxing Crescent	# Dorůstající srpek	# 7
# First Quarter		# První čtvrť		# 0
# Waxing Gibbous	# Dorůstající měsíc	# 3
# Full			# Úplněk		# 1
# Waning Gibbous	# Couvající měsíc	# 3	# (left <-> right)
# Last Quarter		# Poslední čvrť		# 0	# (left <-> right)
# Third Quarter		# Poslední čvrť		# 0	# (left <-> right)
# Waning Crescent	# Ubývající srpek	# 7	# (left <-> right)

# PREASURE

# rising	# ↑
# falling	# ↓
# steady	# =

# ICONS

# 0	# i
# 1	# h
# 2	# h
# 3	# i
# 4	# i
# 5	# k
# 6	# h
# 7	# k
# 8	# g
# 9	# g
# 10	# h
# 11	# g
# 12	# h
# 13	# j
# 14	# k
# 15	# j
# 16	# k
# 17	# i
# 18	# h
# 19	# v	# dust
# 20	# v	# fog
# 21	# v	# haze
# 22	# v	# smoke
# 23	# w
# 24	# w
# 25	# j
# 26	# d
# 27	# d
# 28	# c
# 29	# b
# 30	# b
# 31	# 1
# 32	# a
# 33	# 1
# 34	# b
# 35	# i
# 36	# l
# 37	# f
# 38	# f
# 39	# h
# 40	# h
# 41	# k
# 42	# k
# 43	# k
# 44	# b
# 45	# h
# 46	# k
# 47	# g
# na	# ~