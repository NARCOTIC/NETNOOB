#!/bin/sh
clear

prgm='netnoob'
Yellow="\033[1;33m";
End="\033[0m"

printf $Yellow
printf " _|      _|  _|_|_|_|  _|_|_|_|_|  _|      _|    _|_|      _|_|    _|_|_|  \n"
printf " _|_|    _|  _|            _|      _|_|    _|  _|    _|  _|    _|  _|    _|\n"
printf " _|  _|  _|  _|_|_|        _|      _|  _|  _|  _|    _|  _|    _|  _|_|_|  \n"
printf " _|    _|_|  _|            _|      _|    _|_|  _|    _|  _|    _|  _|    _|\n"
printf " _|      _|  _|_|_|_|      _|      _|      _|    _|_|      _|_|    _|_|_|  \n"
printf "\n"
printf "=============================== NETNOOB 1.0 ===============================\n"
printf "============================= GITHUB/NARCOTIC =============================\n"
printf $End
printf "\n"

error()
{
  printf "ERROR: %s\n" "$2" 1>&2
  [ $1 -gt 0 ] && exit $1
}

if ! [ ${UID:-`id -u`} -eq 0 ]; then
  error 1 'RUN AS ROOT!'
fi

exe()
{
  Red='\033[1;31m'
  Green='\033[1;32m'
  Reset='\033[0m'
  MSG=$1

  shift

  printf "%s... " "$MSG"

  $@ 1> /dev/null 2>&1

  if [ $? -gt 0 ]; then
    printf " $Red[ERROR]$Reset\n"
  else
    printf " $Green[OK]$Reset\n"
  fi

  unset Red Green Reset MSG
}

if [ -f $prgm -a -r $prgm ]; then
  if [ -f "/usr/bin/$prgm" ]; then
    printf "File '/usr/bin/$prgm' Already Exists.\n"
    printf "Overwrite? [Y/N] "
    read YNAnswer
    case $YNAnswer in
      [Yy]|[Yy][Ee][Ss])
            ;;
      [Nn]|[Nn][Oo])
      printf "Nothing Done! Quitting!"
      exit 0 ;;
      *)
      error 1 'Invalid Eesponse! Quitting!' ;;
    esac
  fi

  exe "[1/3] Installing to '/usr/bin/netnoob'" cp "$prgm" /usr/bin/
  exe "[2/3] Setting correct file modes" chmod 755 "/usr/bin/$prgm"
  exe "[3/3] Correcting ownership" chown 0:0 "/usr/bin/$prgm"
  printf "Done!\n"
else
  error 1 'File '$prgm' Missing or Inaccessible.'
fi
# END OF THE PROGRAM
