program Ej1Pr1;

type
	archivo: file of integer;
var
	num:integer;
	arch_num:archivo;
	nombre_arch:string;
BEGIN
	write('ingrese nombre del archivo');
	read(nombre_arch);
	assign (arch_num, nombre_arch);
	rewrite(arch_num);
	write ('ingrese numero');
	read(num);
	while (num<>300) then betgin
		write(arch_num, num);
		write ('ingrese numero');
		read(num);
	end;
	close(arch_num);
END.
