# Function to source files if they exist
safe_source()
{
    [ -f "$1" ] && source "$1"
}

dmalloc(){
    eval `command dmalloc -b $*`;
}
