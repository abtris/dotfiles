#!/usr/bin/perl

use Switch;
use XML::Simple;
use Text::Wrap;
use Encode;

$action			= $ARGV[0];
$channel_index		= $ARGV[1];

$file			= "/tmp/tv.xml";

$Text::Wrap::columns	= 49;
$indent			= "   ";

#====================================================================================

switch($action){
	case "head" {
		&load_data;
		($channel_name, $time, $title) = split (/\s>\s|\n/, $tv->{channel}->{item}[$channel_index]->{title});
		printf ("%-6s $time\n",encode_utf8($channel_name));
		print encode_utf8(wrap $indent, $indent, $title);
	}
	case "description"{
		&load_data;
		print encode_utf8(wrap $indent, $indent, $tv->{channel}->{item}[$channel_index]->{description});
	}
	case "update"{
		`wget -O - "http://www.tampiss.com/rss/tv_online.xml" > $file`;
	}
}

#====================================================================================

sub load_data {
	$xml = new XML::Simple(SuppressEmpty => 1);	
	$tv = $xml->XMLin($file);
}