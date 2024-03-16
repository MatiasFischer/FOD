program Ej4;
type 
	empleado=record 
		num:integer;
		nom:string;
		ape:string;
		edad:integer;
		DNI:integer;
	end;
	
	archivo= file of empleado;

procedure leerEmpleado (var e:empleado);
begin
	writeln('Ingrese un apellido');
	readln(e.ape);
	if (e.ape<>'fin') then begin
		writeln('Ingrese un numero');
		readln(e.num);
		writeln('Ingrese un nombre');
		readln(e.nom);
		writeln('Ingrese una edad');
		readln(e.edad);
		writeln('Ingrese un DNI');
		readln(e.DNI);
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
procedure mostrarDeAUno(var arch_emp:archivo);
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
procedure agregarConChequeo (var arch_emp:archivo);
var
	e:empleado;
	emp_arch:empleado;
	ok:boolean;
begin
	ok:=true;
	seek(arch_emp,0);
	leerEmpleado(e);
	while (e.num<>0) do begin
		while ((not eof(arch_emp)) and (ok)) do begin
			read(arch_emp,emp_arch);
			if (e.num=emp_arch.num) then
				ok:=false;
		end;
		if ok then
			write(arch_emp,e)
		else
			writeln('el empleado ya se encontraba');
		writeln('si quiere agregar otro empleado complete los datos, si ingresa el numero 0, no agregara a nadie mas');
		seek(arch_emp,0);
		leerEmpleado(e);
	end;
end;
procedure ModificarEdad (var arch_emp:archivo; dni:integer);
var
	e:empleado;
	ok:boolean;
	edad:integer;
begin
	ok:=true;
	leerEmpleado(e);
	while not eof(arch_emp) and ok do begin
		read(arch_emp, e);
		if (e.DNI=DNI) then begin
			ok:=false;
			writeln('ingrese nueva edad');
			readln(edad);
			e.edad:=edad;
			seek(arch_emp, filepos(arch_emp)-1);
			write(arch_emp,e);	
			writeln('se modifico la edad con exito');	
		end;
	end;
	if ok then
		writeln('el empleado no se encuentra');		
end;
procedure ExportarTodo
procedure abroArchivo(var arch_emp:archivo);
var
	opcionElegida:char;
begin
	writeln ('Ingrese opcion que desea realizar con archivo abierto');
	writeln ('');
	writeln('a. Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
	writeln('b. Listar en pantalla los empleados de a uno por linea.');
	writeln('c. Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse.');
	writeln ('');
	write 	('OPCION ELEGIDA -->  ');
	readln (opcionElegida);
	writeln ('');
	case opcionElegida of
		'a': mostrarDeterminado(arch_emp);
		'b': mostrarDeAUno(arch_emp);
		'c': mostrarMayores(arch_emp);
	end;
end;
procedure menu (var arch_emp:archivo);
var
	opcionElegida,num:integer; 
begin
	writeln ('ingrese opcion');
	writeln ('');
	writeln ('1) CREAR EL ARCHIVO');
	writeln ('');
	writeln ('2) ABRIR EL ARCHIVO');
	writeln ('');
	writeln ('3) ANIADIR EMPLEADO');
	writeln ('');
	writeln ('4) MODIFICAR EDAD');
	writeln ('');
	writeln ('5) EXPORTAR CONTENIDO A "todos_empleados.txt"');
	writeln ('');
	writeln ('6) EXPORTAR A QUIENES NO TENGAN DNI A "faltaDNIEmpleado.txt"');
	writeln ('');
	write 	('OPCION ELEGIDA -->  ');
	readln(opcionElegida);
	case opcionElegida of
		1:crear(arch_emp);
		2: begin
			reset(arch_emp);
			abroArchivo(arch_emp);
		   end;
		3: agregarConChequeo(arch_emp);
		4: begin
			reset(arch_log):
			writeln('ingrese numero de empleado al que se modificara la edad');
			readln(num);
			ModificarEdad(arch_emp,num);
		   end;	
	end;
end;
var
	letra:char;
	nom_arch:string;
	arch_emp:archivo;
	seguir:boolean;
begin
	seguir:=true;
	writeln ('ingrese nombre del archivo');
	readln(nom_arch);
	Assign(arch_emp, nom_arch);
	menu(arch_emp);
	while (seguir) do begin
		writeln('si quiere relaizar otra accion pulse la letra c');
		readln(letra);
		if (letra='c') then 
			menu(arch_emp)
		else begin
			seguir:=false;
			close(arch_emp);
		end;	
	end;
end.
