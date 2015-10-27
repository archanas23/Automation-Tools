#!/user/bin/perl

use Cwd;
use File::Copy;

#get the path of the folder of the source file
$path=getcwd();
$dir = "$path/FVT"; 
$dir_Xl = "$path/FVT Scenarios";

#open the directory of the source file
opendir(DIR, $dir_Xl) or die "can't opendir $dir: $! \n";

#read the files in the current directory
@file_of_dir=readdir(DIR);

#close the directory
closedir DIR;
#print "@file_of_dir\n";

#search for the file that is needed to move
foreach $file (@file_of_dir)
{
if($file=~ m/^FVT_/){
$folder=$file;
$folder=~ s/_TP.xls$//;
$folder=~ s/_TP.xlsx$//;
$source = "$dir_Xl/$file";
$target = "$dir/$folder";

#copy it to the destination folder
copy $source => $target or warn "Copy of $file failed: $!";
}
#renaming the file
foreach (@file_of_dir)
{
$new=$_;
$new=~ s/.xls/_TP.xls/ if($_ =~ m/.xls$/);
$new=~ s/.xlsx/_TP.xlsx/ if($_ =~ m/.xlsx$/);
rename("$path/$_", "$path/$new");
}
}


