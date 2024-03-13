program Ej2Pr1;
type
	archivo: file of integer;

procedure mostrarPantalla (var arch_num:archivo; var cantM,cant:integer; var promedio:real);
var	
	num:integer;
begin
	reset (arch_num);
	while not eof(arch_num) do begin
		cant:=cant +1;
		read(arch_num, num);
		if (num<150) then
			cantM:=cantM+1;
		promedio:=promedio + num;
		write(num);
	end;	
	close(arch_num);
end;

var
	num, cant, cantM:integer;
	promedio:real;
	arch_num:archivo;
	nombre_arch:string;
BEGIN
	cant, cantM:=0;
	promedio:=0;
	write('ingrese nombre del archivo');
	read(nombre_arch);
	assign (arch_num, nombre_arch);
	mostrarPantalla(arch_num, cantM, cant, promedio);
	write('la cant de numeros menores a 1500 es de:', cantM);
	write('el promedio de los numeros ingresados es de: ', promedio/cant); 	
END.
