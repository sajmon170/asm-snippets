PROGRAM=$(echo $1 | cut -d "." -f 1)

if [[ "$1" == "clean" ]]; then
	rm *.o
	exit 0
fi

if [[ -z $PROGRAM ]]; then
	echo "assemble: no file provided!"
	exit 1
fi

yasm $PROGRAM.asm -f elf64 -o $PROGRAM.o
if [[ $? -eq 0 ]]; then
	ld $PROGRAM.o -o $PROGRAM
fi
