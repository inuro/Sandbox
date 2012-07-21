#!/usr/bin/perl

use strict;
use File::Copy;

opendir(DIR, ".") or die;
my @files = readdir(DIR);
foreach(@files){
    if(/\.(jpg|png|mov)$/i){
        my $file = $_;
        my $date = (stat $file)[9];
        my ($sec,$min,$hour,$mday,$mon,$year) = localtime($date);
        $year = $year + 1900;
        $mon = $mon + 1;
        $mon = $mon < 10 ? '0' . $mon : $mon;
        $mday = $mday < 10 ? '0' . $mday : $mday;
        my $dir = $year . '-' . $mon . '-' . $mday;
        my $path = '/Users/inuro/Pictures/' . $dir;
        #check directory exists
        if(! -e $path){
            print "no such dir:" . $path . "\n";
            mkdir $path or die "cannot make dir:" . $path;
        }
        #move file
        if(-d $path){
            if(move $file, $path){
                print $file . " -> " . $path . "\n";
            }
            else{
                print "CANNOT move " . $file . " to " . $path . "(" . $! . ")\n";
            }
        }
        else{
            print $path . " is not a diretory\n";
        }
        
        #print $file . " -> " . $path . "\n";
    }
}

exit;
