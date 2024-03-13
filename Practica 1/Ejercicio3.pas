program Ej3a
type 
	empleado=record 
		num:integer;
		nom:string;
		ape:string;
		edad:integer;
		DNI:integer;
	end;
	
	archivo: file of empleado;

procedure leerEmpleado (var e:empleado);
begin
	read(e.ape);
	if (e.ape<>'fin') then begin
		read(e.num);
		read(e.nom);
		read(e.edad);
		read(e.DNI);
	end;
end;
procedure crear (var arch_emp:archivo);
var
	e:empleado;
begin
	rewrite(arch_emp);
	leerEmpleado(e);
	while (e.ape<>'fin') do begin
		write(arch_emp,e);
		leerEmpleado(e);
	end;
	close(arch_emp);
end;
procedure imprimirEmpleado(e:empleado);
begin
	with e do begin
		writeln('NUM: ', num);
		writeln('NOMBRE: ', nom);
		writeln('APELLIDO: ', ape);
		writeln('EDAD: ', edad);
		writeln('DNI: ', DNI);
	end;
end;
procedure mostrarDeterminado(var arch_emp:archivo);
var
	nomOape:string;
	e:empleado;
begin
	write('ingrese nombre o apellido');
	read(nomOape);
	while not eof(arch_emp) do begin
		read(arch_emp, e);
		if (e.ape=nomOape) or (e.nom=nomOape) then
			imprimirEmpleado(e);
	end;
end;
procedure mostrarDeAUno(var arch_emp);
var
	e:empleado;
begin
	while not eof(arch_emp) do begin
		read(arch_emp,e);
		imprimirEmpleado(e);
	end;
end;
procedure mostrarMayores(var arch_emp:archivo);
var
	e:empleado;
begin
	while not eof(arch_emp) do begin
		read(arch_emp,e);
		if (e.edad>70) then
			imprimirEmpleado(e);
	end;
end;
procedure abroArchivo(var arch_emp:archivo);
var
	opcionElegida:string;
begin
	writeln ('ingrese opcion');
	readln(opcionElegida);
	if (opcionElegida='a') then
		mostrarDeterminado(arch_emp);
	else if (opcionElegida='b')then
		mostrarDeAUno(arch_emp);
	else 
		mostrarMayores(arch_emp);
end;
procedure menu (var arch_emp:archivo);
var
	opcionElegida:integer; 
begin
	writeln ('ingrese opcion');
	readln(opcionElegida);
	if (opcionElegida='a')then
		crear(arch_emp);
	else 
		abroArchivo(arch_emp);
end;
var
	letra:char;
	nom_arch:string;
	arch_emp:archivo;
	e:empleado;
	seguir:boolean;
begin
	seguir:=true;
	write ('ingrese nombre del archivo');
	read(nom_arch);
	Assign(arch_emp, nom_arch);
	menu(arch_emp);
	while (seguir=true) do begin
		write('si quiere relaizar otra accion pulse la letra c');
		read(letra);
		if (letra='c') then 
			menu(arch_emp);
		else begin
			seguir:=false;
			close(arch_emp);	
end.
